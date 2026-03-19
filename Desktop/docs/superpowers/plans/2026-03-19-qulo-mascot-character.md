# Qulo Mascot Character 3D Prototype — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a 3D mascot character prototype in a single HTML file with 5 interactive animations (idle, wave, heart, walk, point) using Three.js.

**Architecture:** Single HTML file with embedded Three.js (CDN). Character built from primitives (spheres, cylinders) in a parent-child hierarchy. Fully procedural animation system — each animation is a function that sets transforms based on time. Crossfade blending between animations via weighted pose interpolation.

**Tech Stack:** Three.js r170 (CDN), OrbitControls (CDN), vanilla HTML/CSS/JS

**Spec:** `docs/superpowers/specs/2026-03-19-qulo-mascot-character-design.md`

---

## File Structure

- **Create:** `qulo-mascot.html` — Single self-contained HTML file with all code

---

### Task 1: Scene, Character Model, UI Shell

Create the complete HTML file with scene, full character model (body, head, face, limbs), UI buttons, and a placeholder animate loop. No animations yet — just a static character you can orbit around.

**Files:**
- Create: `qulo-mascot.html`

- [ ] **Step 1: Create the complete HTML file with scene + character + UI**

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Qulo Mascot — 3D Prototype</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { overflow: hidden; background: #1a1a2e; font-family: 'Segoe UI', sans-serif; }
    #canvas-container { width: 100vw; height: 100vh; }
    canvas { display: block; }
    #controls {
      position: fixed; bottom: 24px; left: 50%; transform: translateX(-50%);
      display: flex; gap: 10px; z-index: 10;
    }
    #controls button {
      padding: 10px 18px; border: 2px solid rgba(155, 89, 182, 0.6);
      border-radius: 12px; background: rgba(26, 26, 46, 0.85); color: #fff;
      font-size: 14px; font-weight: 600; cursor: pointer;
      backdrop-filter: blur(8px); transition: all 0.2s;
    }
    #controls button:hover { background: rgba(155, 89, 182, 0.3); border-color: #9b59b6; }
    #controls button.active {
      background: rgba(155, 89, 182, 0.5); border-color: #9b59b6;
      box-shadow: 0 0 12px rgba(155, 89, 182, 0.4);
    }
    #camera-reset {
      position: fixed; top: 16px; right: 16px; padding: 8px 14px;
      border: 1px solid rgba(255,255,255,0.2); border-radius: 8px;
      background: rgba(26, 26, 46, 0.7); color: #aaa; font-size: 12px;
      cursor: pointer; z-index: 10;
    }
    #camera-reset:hover { color: #fff; border-color: rgba(255,255,255,0.4); }
    #title {
      position: fixed; top: 16px; left: 50%; transform: translateX(-50%);
      color: rgba(255,255,255,0.6); font-size: 16px; font-weight: 300;
      letter-spacing: 2px; z-index: 10;
    }
  </style>
</head>
<body>
  <div id="canvas-container"></div>
  <div id="title">QULO MASCOT</div>
  <div id="controls">
    <button data-anim="idle" class="active">Idle</button>
    <button data-anim="wave">Wave</button>
    <button data-anim="heart">Heart</button>
    <button data-anim="walk">Walk</button>
    <button data-anim="point">Point</button>
  </div>
  <button id="camera-reset">Reset Camera</button>

  <script type="importmap">
  {
    "imports": {
      "three": "https://cdn.jsdelivr.net/npm/three@0.170.0/build/three.module.js",
      "three/addons/": "https://cdn.jsdelivr.net/npm/three@0.170.0/examples/jsm/"
    }
  }
  </script>
  <script type="module">
    import * as THREE from 'three';
    import { OrbitControls } from 'three/addons/controls/OrbitControls.js';

    // === SCENE SETUP ===
    const scene = new THREE.Scene();

    // Gradient background
    const bgCanvas = document.createElement('canvas');
    bgCanvas.width = 2; bgCanvas.height = 512;
    const bgCtx = bgCanvas.getContext('2d');
    const bgGrad = bgCtx.createLinearGradient(0, 0, 0, 512);
    bgGrad.addColorStop(0, '#1a1a2e'); bgGrad.addColorStop(1, '#16213e');
    bgCtx.fillStyle = bgGrad; bgCtx.fillRect(0, 0, 2, 512);
    scene.background = new THREE.CanvasTexture(bgCanvas);

    const camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 0.1, 100);
    camera.position.set(0, 1.5, 5);

    const renderer = new THREE.WebGLRenderer({ antialias: true });
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    renderer.shadowMap.enabled = true;
    renderer.shadowMap.type = THREE.PCFSoftShadowMap;
    document.getElementById('canvas-container').appendChild(renderer.domElement);

    const controls = new OrbitControls(camera, renderer.domElement);
    controls.target.set(0, 1, 0);
    controls.enableDamping = true;
    controls.dampingFactor = 0.05;
    controls.update();

    // Lights
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.6);
    scene.add(ambientLight);
    const dirLight = new THREE.DirectionalLight(0xffffff, 0.8);
    dirLight.position.set(3, 5, 4);
    dirLight.castShadow = true;
    dirLight.shadow.mapSize.set(1024, 1024);
    scene.add(dirLight);

    // Ground
    const groundGeo = new THREE.CircleGeometry(3, 64);
    const groundMat = new THREE.MeshStandardMaterial({ color: 0x16213e, roughness: 0.8 });
    const ground = new THREE.Mesh(groundGeo, groundMat);
    ground.rotation.x = -Math.PI / 2;
    ground.receiveShadow = true;
    scene.add(ground);

    // === COLOR PALETTE ===
    const COLORS = {
      body: 0x9b59b6, bodyDark: 0x7d3c98,
      white: 0xffffff, black: 0x1a1a1a,
      blush: 0xff9ff3, mouth: 0xe74c3c,
    };

    // === CHARACTER ===
    const character = new THREE.Group();
    character.position.y = 0.01;
    scene.add(character);

    // Shadow under character
    const shadowGeo = new THREE.CircleGeometry(0.4, 32);
    const shadowMat = new THREE.MeshBasicMaterial({ color: 0x000000, transparent: true, opacity: 0.2 });
    const shadowRing = new THREE.Mesh(shadowGeo, shadowMat);
    shadowRing.rotation.x = -Math.PI / 2; shadowRing.position.y = 0.005;
    character.add(shadowRing);

    // Body
    const bodyGeo = new THREE.SphereGeometry(0.5, 32, 32);
    const bodyMat = new THREE.MeshStandardMaterial({ color: COLORS.body, roughness: 0.4 });
    const body = new THREE.Mesh(bodyGeo, bodyMat);
    body.position.y = 1.0; body.castShadow = true;
    character.add(body);

    // Head
    const headGeo = new THREE.SphereGeometry(0.38, 32, 32);
    const headMat = new THREE.MeshStandardMaterial({ color: COLORS.body, roughness: 0.4 });
    const head = new THREE.Mesh(headGeo, headMat);
    head.position.y = 0.55; head.castShadow = true;
    body.add(head);

    // Eyes
    const eyeWhiteGeo = new THREE.SphereGeometry(0.1, 16, 16);
    const eyeWhiteMat = new THREE.MeshStandardMaterial({ color: COLORS.white });
    const pupilGeo = new THREE.SphereGeometry(0.06, 16, 16);
    const pupilMat = new THREE.MeshStandardMaterial({ color: COLORS.black });
    const heartPupilMat = new THREE.MeshStandardMaterial({ color: 0xff4757 }); // reused in heart animation

    const leftEye = new THREE.Group();
    const leftEyeWhite = new THREE.Mesh(eyeWhiteGeo, eyeWhiteMat);
    const leftPupil = new THREE.Mesh(pupilGeo, pupilMat);
    leftPupil.position.z = 0.06;
    leftEye.add(leftEyeWhite, leftPupil);
    leftEye.position.set(-0.13, 0.05, 0.32);
    head.add(leftEye);

    const rightEye = new THREE.Group();
    const rightEyeWhite = new THREE.Mesh(eyeWhiteGeo.clone(), eyeWhiteMat);
    const rightPupil = new THREE.Mesh(pupilGeo.clone(), pupilMat);
    rightPupil.position.z = 0.06;
    rightEye.add(rightEyeWhite, rightPupil);
    rightEye.position.set(0.13, 0.05, 0.32);
    head.add(rightEye);

    // Ears
    const earGeo = new THREE.SphereGeometry(0.1, 16, 16, 0, Math.PI * 2, 0, Math.PI / 2);
    const earMat = new THREE.MeshStandardMaterial({ color: COLORS.body });
    const leftEar = new THREE.Mesh(earGeo, earMat);
    leftEar.position.set(-0.28, 0.25, 0); leftEar.rotation.z = 0.3;
    head.add(leftEar);
    const rightEar = new THREE.Mesh(earGeo.clone(), earMat);
    rightEar.position.set(0.28, 0.25, 0); rightEar.rotation.z = -0.3;
    head.add(rightEar);

    // Mouth
    const mouthGeo = new THREE.SphereGeometry(0.04, 16, 16);
    const mouthMat = new THREE.MeshStandardMaterial({ color: COLORS.mouth });
    const mouth = new THREE.Mesh(mouthGeo, mouthMat);
    mouth.position.set(0, -0.12, 0.34); mouth.scale.set(1.5, 0.8, 0.5);
    head.add(mouth);

    // Blush
    const blushGeo = new THREE.SphereGeometry(0.05, 16, 16);
    const blushMat = new THREE.MeshStandardMaterial({ color: COLORS.blush, transparent: true, opacity: 0.5 });
    const leftBlush = new THREE.Mesh(blushGeo, blushMat);
    leftBlush.position.set(-0.22, -0.05, 0.28); leftBlush.scale.set(1.3, 0.8, 0.3);
    head.add(leftBlush);
    const rightBlush = new THREE.Mesh(blushGeo.clone(), blushMat);
    rightBlush.position.set(0.22, -0.05, 0.28); rightBlush.scale.set(1.3, 0.8, 0.3);
    head.add(rightBlush);

    // Antenna (question mark curl)
    const antennaCurvePoints = [];
    for (let i = 0; i <= 20; i++) {
      const t = i / 20;
      antennaCurvePoints.push(new THREE.Vector3(
        Math.sin(t * Math.PI * 1.5) * 0.12 * (1 - t * 0.3),
        t * 0.4,
        Math.cos(t * Math.PI * 1.5) * 0.08 * (1 - t * 0.3)
      ));
    }
    const antennaCurve = new THREE.CatmullRomCurve3(antennaCurvePoints);
    const antennaGeo = new THREE.TubeGeometry(antennaCurve, 20, 0.03, 8, false);
    const antennaMat = new THREE.MeshStandardMaterial({ color: COLORS.bodyDark });
    const antenna = new THREE.Mesh(antennaGeo, antennaMat);
    antenna.position.y = 0.35; antenna.castShadow = true;
    head.add(antenna);
    const tipGeo = new THREE.SphereGeometry(0.05, 16, 16);
    const tip = new THREE.Mesh(tipGeo, antennaMat);
    tip.position.copy(antennaCurvePoints[antennaCurvePoints.length - 1]);
    tip.position.y += 0.35;
    head.add(tip);

    // === LIMBS ===
    const limbMat = new THREE.MeshStandardMaterial({ color: COLORS.body, roughness: 0.4 });
    const limbDarkMat = new THREE.MeshStandardMaterial({ color: COLORS.bodyDark, roughness: 0.4 });
    const armGeo = new THREE.CylinderGeometry(0.05, 0.04, 0.3, 16);
    const handGeo = new THREE.SphereGeometry(0.06, 16, 16);

    // Left arm
    const leftArmPivot = new THREE.Group();
    leftArmPivot.position.set(-0.45, 0.1, 0);
    body.add(leftArmPivot);
    const leftArm = new THREE.Mesh(armGeo, limbMat);
    leftArm.position.y = -0.15; leftArm.castShadow = true;
    leftArmPivot.add(leftArm);
    const leftHand = new THREE.Mesh(handGeo, limbDarkMat);
    leftHand.position.y = -0.3; leftHand.castShadow = true;
    leftArmPivot.add(leftHand);

    // Right arm
    const rightArmPivot = new THREE.Group();
    rightArmPivot.position.set(0.45, 0.1, 0);
    body.add(rightArmPivot);
    const rightArm = new THREE.Mesh(armGeo.clone(), limbMat);
    rightArm.position.y = -0.15; rightArm.castShadow = true;
    rightArmPivot.add(rightArm);
    const rightHand = new THREE.Mesh(handGeo.clone(), limbDarkMat);
    rightHand.position.y = -0.3; rightHand.castShadow = true;
    rightArmPivot.add(rightHand);

    // Left leg
    const legGeo = new THREE.CylinderGeometry(0.06, 0.05, 0.3, 16);
    const footGeo = new THREE.SphereGeometry(0.07, 16, 16);
    const leftLegPivot = new THREE.Group();
    leftLegPivot.position.set(-0.18, -0.4, 0);
    body.add(leftLegPivot);
    const leftLeg = new THREE.Mesh(legGeo, limbMat);
    leftLeg.position.y = -0.15; leftLeg.castShadow = true;
    leftLegPivot.add(leftLeg);
    const leftFoot = new THREE.Mesh(footGeo, limbDarkMat);
    leftFoot.position.y = -0.32; leftFoot.castShadow = true;
    leftLegPivot.add(leftFoot);

    // Right leg
    const rightLegPivot = new THREE.Group();
    rightLegPivot.position.set(0.18, -0.4, 0);
    body.add(rightLegPivot);
    const rightLeg = new THREE.Mesh(legGeo.clone(), limbMat);
    rightLeg.position.y = -0.15; rightLeg.castShadow = true;
    rightLegPivot.add(rightLeg);
    const rightFoot = new THREE.Mesh(footGeo.clone(), limbDarkMat);
    rightFoot.position.y = -0.32; rightFoot.castShadow = true;
    rightLegPivot.add(rightFoot);

    // === ANIMATION STATE ===
    let currentAnim = 'idle';
    let animTime = 0;
    let prevAnim = null;
    let prevAnimTime = 0;
    let crossfadeRemaining = 0;
    const CROSSFADE_DURATION = 0.3;

    // Default pose snapshot (used for resetPose)
    const DEFAULT_BODY_Y = 1.0;

    function resetPose() {
      body.position.set(0, DEFAULT_BODY_Y, 0);
      body.rotation.set(0, 0, 0);
      head.rotation.set(0, 0, 0);
      leftArmPivot.rotation.set(0, 0, 0);
      rightArmPivot.rotation.set(0, 0, 0);
      leftLegPivot.rotation.set(0, 0, 0);
      rightLegPivot.rotation.set(0, 0, 0);
      leftEye.scale.set(1, 1, 1);
      rightEye.scale.set(1, 1, 1);
    }

    function switchAnimation(name) {
      if (currentAnim === name && crossfadeRemaining <= 0) return;
      prevAnim = currentAnim;
      prevAnimTime = animTime;
      crossfadeRemaining = CROSSFADE_DURATION;
      currentAnim = name;
      animTime = 0;
    }

    const animDurations = { idle: 2, wave: 1.5, heart: 2, walk: 1, point: 1.5 };
    const loopAnims = new Set(['idle', 'walk']);

    // Placeholder animate — will be replaced in Task 2
    const clock = new THREE.Clock();
    function animate() {
      requestAnimationFrame(animate);
      const delta = clock.getDelta();
      controls.update();
      renderer.render(scene, camera);
    }

    // === UI CONTROLS ===
    const buttons = document.querySelectorAll('#controls button');
    function setActiveButton(animName) {
      buttons.forEach(b => b.classList.toggle('active', b.dataset.anim === animName));
    }
    buttons.forEach(btn => {
      btn.addEventListener('click', () => {
        switchAnimation(btn.dataset.anim);
        setActiveButton(btn.dataset.anim);
      });
    });
    document.getElementById('camera-reset').addEventListener('click', () => {
      camera.position.set(0, 1.5, 5);
      controls.target.set(0, 1, 0);
      controls.update();
    });

    // Resize
    window.addEventListener('resize', () => {
      camera.aspect = window.innerWidth / window.innerHeight;
      camera.updateProjectionMatrix();
      renderer.setSize(window.innerWidth, window.innerHeight);
    });

    // Start
    animate();
  </script>
</body>
</html>
```

- [ ] **Step 2: Open in browser to verify**

Run: `open qulo-mascot.html`
Expected: Purple character (body, head, eyes, ears, mouth, blush, antenna, arms, legs) standing on dark circular ground. Orbit camera works. Buttons visible at bottom but don't do anything yet.

- [ ] **Step 3: Commit**

```bash
git add qulo-mascot.html
git commit -m "feat: scene, character model, and UI shell"
```

---

### Task 2: Procedural Animation System + Idle Animation

Replace the placeholder `animate()` with the full procedural animation system. Add idle animation (breathing, antenna sway, eye blink).

**Files:**
- Modify: `qulo-mascot.html`

- [ ] **Step 1: Replace the placeholder animate function and add idle**

Replace everything from `// Placeholder animate` to `animate();` with:

```javascript
    // === PROCEDURAL ANIMATIONS ===
    function applyIdle(t) {
      body.position.y = DEFAULT_BODY_Y + Math.sin(t * Math.PI) * 0.03;
    }

    // (wave, heart, walk, point will be added in subsequent tasks)
    function applyWave(t) { applyIdle(t); }
    function applyHeart(t) { applyIdle(t); }
    function applyWalk(t) { applyIdle(t); }
    function applyPoint(t) { applyIdle(t); }

    const animFunctions = { idle: applyIdle, wave: applyWave, heart: applyHeart, walk: applyWalk, point: applyPoint };

    function applyAnimationWeighted(name, t, weight) {
      // Save current pose, apply animation, then blend
      // For simplicity: apply at full weight, caller handles blending via two passes
      const fn = animFunctions[name];
      if (fn) fn(t);
    }

    // === HEART PARTICLES ===
    const hearts = [];

    function createHeart(size) {
      const shape = new THREE.Shape();
      shape.moveTo(0, size * 0.3);
      shape.bezierCurveTo(0, size, -size, size, -size, size * 0.3);
      shape.bezierCurveTo(-size, 0, 0, -size * 0.2, 0, -size * 0.7);
      shape.bezierCurveTo(0, -size * 0.2, size, 0, size, size * 0.3);
      shape.bezierCurveTo(size, size, 0, size, 0, size * 0.3);
      const geo = new THREE.ExtrudeGeometry(shape, { depth: 0.05, bevelEnabled: true, bevelSize: 0.02, bevelThickness: 0.02 });
      const mat = new THREE.MeshStandardMaterial({ color: 0xff4757, transparent: true });
      return new THREE.Mesh(geo, mat);
    }

    function spawnHeart() {
      const heart = createHeart(0.1);
      heart.position.set(0, 1.5, 0.3);
      heart.userData = { velocity: new THREE.Vector3((Math.random() - 0.5) * 0.5, 1.5 + Math.random(), 0.3), life: 1.0 };
      scene.add(heart);
      hearts.push(heart);
    }

    function updateHearts(delta) {
      for (let i = hearts.length - 1; i >= 0; i--) {
        const h = hearts[i];
        h.userData.life -= delta * 0.8;
        h.position.add(h.userData.velocity.clone().multiplyScalar(delta));
        h.userData.velocity.y -= delta * 0.5;
        h.rotation.z += delta * 2;
        h.scale.setScalar(Math.max(0, h.userData.life));
        h.material.opacity = h.userData.life;
        if (h.userData.life <= 0) { scene.remove(h); h.geometry.dispose(); hearts.splice(i, 1); }
      }
    }

    // === ALWAYS-ON EFFECTS ===
    let blinkTimer = 0;
    const BLINK_INTERVAL = 3.5;
    const BLINK_DURATION = 0.15;

    function applyAlwaysOnEffects(elapsed, delta) {
      // Antenna sway
      antenna.rotation.z = Math.sin(elapsed * 1.5) * 0.1;
      antenna.rotation.x = Math.cos(elapsed * 1.2) * 0.05;

      // Eye blink
      blinkTimer += delta;
      if (blinkTimer > BLINK_INTERVAL) {
        const blinkPhase = blinkTimer - BLINK_INTERVAL;
        if (blinkPhase < BLINK_DURATION) {
          const t = blinkPhase / BLINK_DURATION;
          const scaleY = t < 0.5 ? 1 - t * 2 * 0.9 : 0.1 + (t - 0.5) * 2 * 0.9;
          leftEye.scale.y = scaleY;
          rightEye.scale.y = scaleY;
        } else {
          leftEye.scale.y = 1;
          rightEye.scale.y = 1;
          blinkTimer = 0;
        }
      }
    }

    // === MAIN ANIMATE LOOP ===
    const clock = new THREE.Clock();

    function animate() {
      requestAnimationFrame(animate);
      const delta = clock.getDelta();
      const elapsed = clock.getElapsedTime();
      animTime += delta;

      // Reset to default pose
      resetPose();

      // Determine animation time
      const duration = animDurations[currentAnim] || 2;
      let t = loopAnims.has(currentAnim) ? animTime % duration : Math.min(animTime, duration);

      // Check if non-loop animation finished
      if (!loopAnims.has(currentAnim) && animTime >= duration) {
        prevAnim = currentAnim;
        prevAnimTime = t;
        crossfadeRemaining = CROSSFADE_DURATION;
        currentAnim = 'idle';
        animTime = 0;
        t = 0;
        setActiveButton('idle');
      }

      // Apply animation (with crossfade if transitioning)
      if (crossfadeRemaining > 0) {
        crossfadeRemaining -= delta;
        const blend = Math.max(0, crossfadeRemaining / CROSSFADE_DURATION);
        // Apply previous animation at blend weight
        const prevDuration = animDurations[prevAnim] || 2;
        const prevT = loopAnims.has(prevAnim) ? prevAnimTime % prevDuration : Math.min(prevAnimTime, prevDuration);
        applyAnimationWeighted(prevAnim, prevT, blend);
        // Store prev pose
        const prevPose = {
          bodyY: body.position.y, bodyX: body.position.x,
          bodyRotX: body.rotation.x, bodyRotZ: body.rotation.z,
          headRotY: head.rotation.y,
          laRX: leftArmPivot.rotation.x, laRZ: leftArmPivot.rotation.z,
          raRX: rightArmPivot.rotation.x, raRZ: rightArmPivot.rotation.z,
          llRX: leftLegPivot.rotation.x, rlRX: rightLegPivot.rotation.x,
        };
        // Reset and apply current
        resetPose();
        applyAnimationWeighted(currentAnim, t, 1);
        // Blend: lerp from prev to current
        const w = 1 - blend; // weight of current animation
        body.position.y = THREE.MathUtils.lerp(prevPose.bodyY, body.position.y, w);
        body.position.x = THREE.MathUtils.lerp(prevPose.bodyX, body.position.x, w);
        body.rotation.x = THREE.MathUtils.lerp(prevPose.bodyRotX, body.rotation.x, w);
        body.rotation.z = THREE.MathUtils.lerp(prevPose.bodyRotZ, body.rotation.z, w);
        head.rotation.y = THREE.MathUtils.lerp(prevPose.headRotY, head.rotation.y, w);
        leftArmPivot.rotation.x = THREE.MathUtils.lerp(prevPose.laRX, leftArmPivot.rotation.x, w);
        leftArmPivot.rotation.z = THREE.MathUtils.lerp(prevPose.laRZ, leftArmPivot.rotation.z, w);
        rightArmPivot.rotation.x = THREE.MathUtils.lerp(prevPose.raRX, rightArmPivot.rotation.x, w);
        rightArmPivot.rotation.z = THREE.MathUtils.lerp(prevPose.raRZ, rightArmPivot.rotation.z, w);
        leftLegPivot.rotation.x = THREE.MathUtils.lerp(prevPose.llRX, leftLegPivot.rotation.x, w);
        rightLegPivot.rotation.x = THREE.MathUtils.lerp(prevPose.rlRX, rightLegPivot.rotation.x, w);
        prevAnimTime += delta;
      } else {
        applyAnimationWeighted(currentAnim, t, 1);
      }

      // Always-on effects (antenna sway, blink)
      applyAlwaysOnEffects(elapsed, delta);

      // Heart particles
      updateHearts(delta);

      controls.update();
      renderer.render(scene, camera);
    }
```

- [ ] **Step 2: Start the loop**

Replace `animate();` with:
```javascript
    animate();
```

- [ ] **Step 3: Open in browser to verify idle**

Expected: Character gently bobs up and down (breathing), antenna sways, eyes blink every ~3.5s. Buttons visible but only idle works.

- [ ] **Step 4: Commit**

```bash
git add qulo-mascot.html
git commit -m "feat: procedural animation system with idle, crossfade, blink, antenna sway"
```

---

### Task 3: Wave Animation

Replace the `applyWave` stub with the real wave animation.

**Files:**
- Modify: `qulo-mascot.html`

- [ ] **Step 1: Replace applyWave stub**

Replace `function applyWave(t) { applyIdle(t); }` with:

```javascript
    function applyWave(t) {
      // Breathing continues during wave
      body.position.y = DEFAULT_BODY_Y + Math.sin(t * Math.PI * 1.33) * 0.02;

      const phase = t / 1.5; // 0 to 1 over 1.5s
      if (phase < 0.2) {
        // Arm raises up
        const p = phase / 0.2;
        rightArmPivot.rotation.z = THREE.MathUtils.lerp(0, -2.5, p);
        body.rotation.x = THREE.MathUtils.lerp(0, 0.15, p);
      } else if (phase < 0.87) {
        // Wave oscillation (3 waves)
        const osc = Math.sin((phase - 0.2) / 0.67 * Math.PI * 3);
        rightArmPivot.rotation.z = -2.5 + osc * 0.3;
        body.rotation.x = 0.15;
      } else {
        // Arm lowers
        const p = (phase - 0.87) / 0.13;
        rightArmPivot.rotation.z = THREE.MathUtils.lerp(-2.5, 0, p);
        body.rotation.x = THREE.MathUtils.lerp(0.15, 0, p);
      }
    }
```

- [ ] **Step 2: Open browser, click Wave button**

Expected: Right arm raises, waves 3 times with oscillation, arm lowers. Body leans forward during wave. Smooth crossfade from idle, returns to idle when done.

- [ ] **Step 3: Commit**

```bash
git add qulo-mascot.html
git commit -m "feat: wave animation — arm raise, 3x oscillation, body lean"
```

---

### Task 4: Heart-Sending Animation

Replace the `applyHeart` stub. Includes arm movement, heart particle spawning at fixed intervals, and eye-to-heart morph.

**Files:**
- Modify: `qulo-mascot.html`

- [ ] **Step 1: Replace applyHeart stub**

Replace `function applyHeart(t) { applyIdle(t); }` with:

```javascript
    function applyHeart(t) {
      const phase = t / 2.0; // 0 to 1 over 2s
      let heartSpawnPhase = false;

      if (phase < 0.3) {
        // Arms come together in front
        const p = phase / 0.3;
        leftArmPivot.rotation.z = THREE.MathUtils.lerp(0, 1.2, p);
        leftArmPivot.rotation.x = THREE.MathUtils.lerp(0, -0.5, p);
        rightArmPivot.rotation.z = THREE.MathUtils.lerp(0, -1.2, p);
        rightArmPivot.rotation.x = THREE.MathUtils.lerp(0, -0.5, p);
      } else if (phase < 0.5) {
        // Arms open outward
        const p = (phase - 0.3) / 0.2;
        leftArmPivot.rotation.z = THREE.MathUtils.lerp(1.2, 0.5, p);
        rightArmPivot.rotation.z = THREE.MathUtils.lerp(-1.2, -0.5, p);
        leftArmPivot.rotation.x = THREE.MathUtils.lerp(-0.5, 0, p);
        rightArmPivot.rotation.x = THREE.MathUtils.lerp(-0.5, 0, p);
        heartSpawnPhase = true;
      } else if (phase < 0.7) {
        // Hold open pose
        leftArmPivot.rotation.z = 0.5;
        rightArmPivot.rotation.z = -0.5;
        heartSpawnPhase = true;
      } else {
        // Return to neutral
        const p = (phase - 0.7) / 0.3;
        leftArmPivot.rotation.z = THREE.MathUtils.lerp(0.5, 0, p);
        rightArmPivot.rotation.z = THREE.MathUtils.lerp(-0.5, 0, p);
      }

      // Time-based heart spawning: spawn every 0.15s during heart phase
      if (heartSpawnPhase) {
        const spawnInterval = 0.15; // seconds between hearts
        const heartPhaseStart = 0.3 * 2.0; // 0.6s absolute
        const timeSinceSpawnPhase = t - heartPhaseStart;
        const spawnIndex = Math.floor(timeSinceSpawnPhase / spawnInterval);
        // Use a simple flag to avoid duplicate spawns on same index
        if (spawnIndex >= 0 && spawnIndex !== applyHeart._lastSpawnIndex) {
          applyHeart._lastSpawnIndex = spawnIndex;
          spawnHeart();
        }
      }

      // Heart eyes: scale eyes into heart shape during phase 0.3-0.7
      // NOTE: heartPupilMat must be created once alongside other materials (see below)
      if (phase > 0.25 && phase < 0.75) {
        const eyePhase = phase < 0.35 ? (phase - 0.25) / 0.1 : phase > 0.65 ? 1 - (phase - 0.65) / 0.1 : 1;
        // Make eyes red-tinted and slightly heart-shaped (wider X, pinched Y top)
        leftEye.scale.set(1 + eyePhase * 0.3, 1 - eyePhase * 0.2, 1);
        rightEye.scale.set(1 + eyePhase * 0.3, 1 - eyePhase * 0.2, 1);
        // Swap pupils to pre-created red material
        leftPupil.material = eyePhase > 0.5 ? heartPupilMat : pupilMat;
        rightPupil.material = eyePhase > 0.5 ? heartPupilMat : pupilMat;
      } else {
        leftPupil.material = pupilMat;
        rightPupil.material = pupilMat;
      }

      body.position.y = DEFAULT_BODY_Y + Math.sin(t * Math.PI) * 0.02;
    }
    applyHeart._lastSpawnIndex = -1;
```

- [ ] **Step 2: Reset heart spawn tracking when switching to heart animation**

In `switchAnimation()`, add after `animTime = 0;`:

```javascript
      if (name === 'heart') applyHeart._lastSpawnIndex = -1;
```

- [ ] **Step 3: Open browser, click Heart button**

Expected: Arms come together, open up, hearts float upward at regular intervals (not random). Eyes get slightly wider and pupils turn red during peak. Returns to idle.

- [ ] **Step 4: Commit**

```bash
git add qulo-mascot.html
git commit -m "feat: heart animation — arm gesture, timed particles, heart eyes"
```

---

### Task 5: Walk Animation

Replace the `applyWalk` stub with walking cycle.

**Files:**
- Modify: `qulo-mascot.html`

- [ ] **Step 1: Replace applyWalk stub**

Replace `function applyWalk(t) { applyIdle(t); }` with:

```javascript
    function applyWalk(t) {
      const cycle = t / 1.0; // 1-second loop (t is already mod'd by caller)
      const angle = cycle * Math.PI * 2;
      const legSwing = Math.sin(angle) * 0.5;
      const armSwing = Math.sin(angle) * 0.4;
      const bodySway = Math.sin(angle) * 0.03;
      const bodyBob = Math.abs(Math.sin(angle)) * 0.04;

      // Legs alternate
      leftLegPivot.rotation.x = legSwing;
      rightLegPivot.rotation.x = -legSwing;

      // Arms opposite to legs
      leftArmPivot.rotation.x = -armSwing;
      rightArmPivot.rotation.x = armSwing;

      // Body sway and bob
      body.position.x = bodySway;
      body.position.y = DEFAULT_BODY_Y + bodyBob;
      body.rotation.z = -bodySway * 2;
    }
```

- [ ] **Step 2: Open browser, click Walk button**

Expected: Legs and arms swing in alternating rhythm, body sways and bobs. Continuous loop. Smooth crossfade from idle.

- [ ] **Step 3: Commit**

```bash
git add qulo-mascot.html
git commit -m "feat: walk cycle — alternating legs/arms, body sway and bob"
```

---

### Task 6: Point Animation

Replace the `applyPoint` stub.

**Files:**
- Modify: `qulo-mascot.html`

- [ ] **Step 1: Replace applyPoint stub**

Replace `function applyPoint(t) { applyIdle(t); }` with:

```javascript
    function applyPoint(t) {
      body.position.y = DEFAULT_BODY_Y + Math.sin(t * Math.PI * 1.33) * 0.02;

      const phase = t / 1.5; // 0 to 1 over 1.5s
      if (phase < 0.3) {
        // Arm extends to the right, head turns
        const p = phase / 0.3;
        rightArmPivot.rotation.z = THREE.MathUtils.lerp(0, -1.5, p);
        rightArmPivot.rotation.x = THREE.MathUtils.lerp(0, -0.3, p);
        head.rotation.y = THREE.MathUtils.lerp(0, -0.3, p);
        body.rotation.z = THREE.MathUtils.lerp(0, -0.1, p);
      } else if (phase < 0.7) {
        // Hold pointing pose with small emphasizing bounce
        const bounce = Math.sin((phase - 0.3) / 0.4 * Math.PI * 2) * 0.05;
        rightArmPivot.rotation.z = -1.5 + bounce;
        rightArmPivot.rotation.x = -0.3;
        head.rotation.y = -0.3;
        body.rotation.z = -0.1;
      } else {
        // Return to neutral
        const p = (phase - 0.7) / 0.3;
        rightArmPivot.rotation.z = THREE.MathUtils.lerp(-1.5, 0, p);
        rightArmPivot.rotation.x = THREE.MathUtils.lerp(-0.3, 0, p);
        head.rotation.y = THREE.MathUtils.lerp(-0.3, 0, p);
        body.rotation.z = THREE.MathUtils.lerp(-0.1, 0, p);
      }
    }
```

- [ ] **Step 2: Open browser, click Point button**

Expected: Right arm extends sideways, head turns to point direction, body leans slightly. Small bounce emphasis during hold. Returns to idle.

- [ ] **Step 3: Commit**

```bash
git add qulo-mascot.html
git commit -m "feat: point animation — arm extension, head turn, bounce emphasis"
```

---

### Task 7: Final Testing + Polish

Full integration test and any visual tweaks.

**Files:**
- Modify: `qulo-mascot.html`

- [ ] **Step 1: Test all animations in sequence**

Open browser and test:
1. Page loads → idle breathing + antenna sway + eye blink ✓
2. Click Wave → smooth crossfade, arm raises, waves 3x, returns to idle ✓
3. Click Heart → arms meet, hearts float up, eyes change, returns to idle ✓
4. Click Walk → continuous walk cycle, smooth transition ✓
5. Click Point → arm extends right, head turns, returns to idle ✓
6. Rapid clicking between animations → crossfade works without glitches ✓
7. Click Walk → Click Heart mid-walk → smooth crossfade ✓
8. Camera orbit works → rotate, zoom, pan ✓
9. Reset Camera button → camera returns to default position ✓
10. Active button highlights correctly at all times ✓

- [ ] **Step 2: Fix any issues found during testing**

- [ ] **Step 3: Final commit**

```bash
git add qulo-mascot.html
git commit -m "feat: final polish and integration testing complete"
```
