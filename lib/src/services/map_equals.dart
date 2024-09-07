// Only for this file; code taken from the quiver package
// Copyright 2013 Google Inc. All Rights Reserved.

/// Checks [Map]s [a] and [b] for equality.
///
/// Returns `true` if [a] and [b] are both null, or they are the same length
/// and every key `k` in [a] exists in [b] and the values `a[k] == b[k]`.
bool mapsEqual(Map? a, Map? b) {
  if (a == b) return true;
  if (a == null || b == null) return false;
  if (a.length != b.length) return false;

  for (final k in a.keys) {
    var bValue = b[k];
    if (bValue == null && !b.containsKey(k)) return false;
    if (bValue != a[k]) return false;
  }

  return true;
}
