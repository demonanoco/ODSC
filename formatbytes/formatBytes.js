const UNITS = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];

// Converts a byte count to a human-readable string using 1024-based units.
function formatBytes(n) {
  if (typeof n !== 'number' || !Number.isFinite(n) || n < 0) {
    throw new RangeError('formatBytes expects a non-negative finite number');
  }
  let i = 0;
  while (n >= 1024 && i < UNITS.length - 1) {
    n /= 1024;
    i++;
  }
  const value = i === 0 ? n : Math.round(n * 10) / 10;
  return `${value} ${UNITS[i]}`;
}

module.exports = { formatBytes };
