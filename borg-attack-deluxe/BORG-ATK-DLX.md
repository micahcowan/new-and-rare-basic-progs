# Borg Attack Deluxe

* `original.bas`
 * original listing
* `tweaks.bas`
 * bugfix: can cursor up (but not left) to select base for jumps (adds L1472)
 * assume the PRNG is already seeded
 * use `clear` terminal escape sequences, instead of form feed character
 * support lowercase key entry
 * timing tweaks
* `tweaks-vi.bas`
 * same as `tweaks.bas`, but uses Vi-style keybindings rather than A-W-S-D
