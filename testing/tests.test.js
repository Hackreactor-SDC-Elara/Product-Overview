test('Joins strings a and be into ab', () => {
  function concat(x, y) {
    return x + y;
  }
  expect(concat('a', 'b')).toBe('ab');
});