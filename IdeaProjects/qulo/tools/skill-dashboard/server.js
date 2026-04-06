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
  var match = content.match(/^---\n([\s\S]*?)\n---/);
  if (!match) return { name: '', description: '', triggers: '' };

  var raw = match[1];
  var result = { name: '', description: '', triggers: '' };

  var nameMatch = raw.match(/^name:\s*(.+)$/m);
  if (nameMatch) result.name = nameMatch[1].trim();

  // description: tek satir veya multiline (| ile)
  var descIdx = raw.indexOf('description:');
  if (descIdx !== -1) {
    var afterDesc = raw.substring(descIdx + 'description:'.length);
    var firstLine = afterDesc.split('\n')[0].trim();

    if (firstLine === '|' || firstLine === '>') {
      // Multiline: indented satirlari topla
      var lines = afterDesc.split('\n').slice(1);
      var descLines = [];
      for (var i = 0; i < lines.length; i++) {
        // Indent ile baslayan satirlar description'a ait
        if (lines[i].match(/^\s{2,}/) || lines[i].trim() === '') {
          if (lines[i].trim()) descLines.push(lines[i].trim());
        } else {
          break;
        }
      }
      result.description = descLines.join(' ');
    } else if (firstLine) {
      // Tek satir description
      result.description = firstLine;
    }
  }

  var triggerMatch = result.description.match(/[Tt]etikleyiciler?:\s*(.+)/);
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
