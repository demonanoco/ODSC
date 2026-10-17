const test = require('node:test');
const assert = require('node:assert');
const { formatBytes } = require('./formatBytes');

test('formats bytes', () => {
  assert.strictEqual(formatBytes(0), '0 B');
  assert.strictEqual(formatBytes(1023), '1023 B');
});
test('formats larger units', () => {
  assert.strictEqual(formatBytes(1024), '1 KB');
  assert.strictEqual(formatBytes(1536), '1.5 KB');
  assert.strictEqual(formatBytes(1048576), '1 MB');
  assert.strictEqual(formatBytes(1024 ** 3 * 2.5), '2.5 GB');
});
test('caps at PB', () => {
  assert.strictEqual(formatBytes(1024 ** 6), '1024 PB');
});
test('rejects invalid input', () => {
  assert.throws(() => formatBytes(-1), RangeError);
  assert.throws(() => formatBytes(NaN), RangeError);
  assert.throws(() => formatBytes('5'), RangeError);
});
