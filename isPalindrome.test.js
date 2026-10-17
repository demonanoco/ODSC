const test = require('node:test');
const assert = require('node:assert');
const { isPalindrome } = require('./isPalindrome');

test('simple palindromes', () => {
  assert.strictEqual(isPalindrome('racecar'), true);
  assert.strictEqual(isPalindrome('abba'), true);
});
test('ignores case and non-alphanumerics', () => {
  assert.strictEqual(isPalindrome('A man, a plan, a canal: Panama'), true);
});
test('non-palindromes', () => {
  assert.strictEqual(isPalindrome('hello'), false);
});
test('empty and single char', () => {
  assert.strictEqual(isPalindrome(''), true);
  assert.strictEqual(isPalindrome('a'), true);
  assert.strictEqual(isPalindrome('!!'), true);
});
test('digits', () => {
  assert.strictEqual(isPalindrome('12321'), true);
  assert.strictEqual(isPalindrome('12345'), false);
});
