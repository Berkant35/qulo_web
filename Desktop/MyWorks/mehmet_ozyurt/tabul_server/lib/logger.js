// tabul_server/lib/logger.js
// Request-scoped console logger. Her satır [req-{shortId}] prefix ile gider.
// Production'da Winston/Pino'ya yükseltmek kolay; şimdilik console.log yeterli.

const crypto = require('crypto');

function newReqId() {
  return crypto.randomBytes(4).toString('hex'); // 8-char short id
}

function createLogger(reqId) {
  const prefix = `[req-${reqId}]`;
  return {
    reqId,
    info: (...args) => console.log(prefix, ...args),
    warn: (...args) => console.warn(prefix, ...args),
    error: (...args) => console.error(prefix, ...args),
  };
}

module.exports = { newReqId, createLogger };
