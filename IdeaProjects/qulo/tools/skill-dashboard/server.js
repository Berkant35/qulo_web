const express = require('express');
const fs = require('fs');
const path = require('path');
const { execFile } = require('child_process');

const app = express();
const PORT = 17380;

const PROJECT_ROOT = path.resolve(__dirname, '..', '..');
const SKILLS_DIR = path.join(PROJECT_ROOT, '.claude', 'skills');
const BUSINESS_SKILLS_DIR = path.join(SKILLS_DIR, 'businessCaseSkills');

app.use(express.json());

function parseFrontmatter(content) {
  const match = content.match(/^---\n([\s\S]*?)\n---/);
  if (!match) return { name: '', description: '', triggers: '' };

  const raw = match[1];
  const result = { name: '', description: '', triggers: '' };

  const nameMatch = raw.match(/^name:\s*(.+)$/m);
  if (nameMatch) result.name = nameMatch[1].trim();

  const descMatch = raw.match(/description:\s*\|?\s*\n?([\s\S]*?)(?=\n\w|\n---)/);
  if (descMatch) {
    result.description = descMatch[1]
      .split('\n')
      .map(function(line) { return line.trim(); })
      .filter(Boolean)
      .join(' ');
  } else {
    const singleDesc = raw.match(/^description:\s*(.+)$/m);
    if (singleDesc) result.description = singleDesc[1].trim();
  }

  const triggerMatch = result.description.match(/[Tt]etikleyiciler?:\s*(.+)/);
  if (triggerMatch) result.triggers = triggerMatch[1].trim();

  return result;
}

function categorizeSkill(filePath, name) {
  if (filePath.includes('businessCaseSkills')) return 'businessCase';
  var lcName = name.toLowerCase();
  if (lcName.includes('ready') || lcName.includes('close')) return 'lifecycle';
  if (lcName.includes('review') || lcName.includes('security') || lcName.includes('quality')) return 'review';
  if (lcName.includes('deploy') || lcName.includes('env') || lcName.includes('testflight')) return 'deploy';
  return 'other';
}

function scanSkills() {
  var skills = [];
  var dirs = [SKILLS_DIR, BUSINESS_SKILLS_DIR];

  for (var i = 0; i < dirs.length; i++) {
    var dir = dirs[i];
    if (!fs.existsSync(dir)) continue;

    var entries = fs.readdirSync(dir);
    for (var j = 0; j < entries.length; j++) {
      var entry = entries[j];
      var filePath = path.join(dir, entry);
      var stat = fs.statSync(filePath);

      if (stat.isDirectory() || !entry.endsWith('.md')) continue;

      var content = fs.readFileSync(filePath, 'utf-8');
      var meta = parseFrontmatter(content);
      if (!meta.name) continue;

      skills.push({
        name: meta.name,
        description: meta.description,
        triggers: meta.triggers,
        category: categorizeSkill(filePath, meta.name),
        file: path.relative(PROJECT_ROOT, filePath),
        lastModified: stat.mtime.toISOString(),
      });
    }
  }

  return skills;
}

app.get('/api/skills', function(_req, res) {
  try {
    var skills = scanSkills();
    res.json({ skills: skills, scannedAt: new Date().toISOString() });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

var activeRuns = new Map();
var VALID_SKILL_NAME = /^[a-zA-Z0-9_-]+$/;

app.post('/api/run-skill', function(req, res) {
  var skillName = req.body.skillName;
  if (!skillName || typeof skillName !== 'string') {
    return res.status(400).json({ error: 'skillName required' });
  }

  if (!VALID_SKILL_NAME.test(skillName)) {
    return res.status(400).json({ error: 'Invalid skill name' });
  }

  if (activeRuns.has(skillName)) {
    return res.status(409).json({ error: 'Skill already running', skillName: skillName });
  }

  activeRuns.set(skillName, { startedAt: new Date().toISOString() });

  var child = execFile('claude', ['-p', '/' + skillName], {
    cwd: PROJECT_ROOT,
    timeout: 300000,
  }, function(error) {
    activeRuns.delete(skillName);
    if (error) {
      console.error('[' + skillName + '] error:', error.message);
    } else {
      console.log('[' + skillName + '] done');
    }
  });

  res.json({
    status: 'started',
    skillName: skillName,
    pid: child.pid,
    startedAt: activeRuns.get(skillName).startedAt,
  });
});

app.get('/api/status', function(_req, res) {
  var running = {};
  activeRuns.forEach(function(info, name) {
    running[name] = info;
  });
  res.json({ running: running, count: activeRuns.size });
});

app.get('/', function(_req, res) {
  res.sendFile(path.join(__dirname, 'index.html'));
});

app.listen(PORT, function() {
  console.log('');
  console.log('  Qulo Skill Dashboard');
  console.log('  http://localhost:' + PORT);
  console.log('');
  console.log('  Project: ' + PROJECT_ROOT);
  console.log('  Skills dir: ' + SKILLS_DIR);
  console.log('');
});
