let { tap, hold, td, combo, .. } = import "../../fak/keycode.ncl" in

# We alias commonly used stuff, so we don't end up repeating them over and over.
let kc = tap.reg.kc in
let me = tap.custom.media in
let XXXX = tap.none & hold.none in
let TTTT = tap.trans & hold.trans in

# "cu" for custom keys. This is just a name, so it can be whatever you want.
let cu = {
  # Again, these are just names. They don't have to be 4-letter or capitalized.
  COPY = tap.reg.mod.lctl & kc.C,
  PSTE = tap.reg.mod.lctl & kc.V,
  CUT =  tap.reg.mod.lctl & kc.X,
  CLOS = tap.reg.mod.lalt & kc.F4,

  # Yep. Such names are possible in Nickel.
  ":P" = tap.reg.mod.lctl & tap.reg.mod.lalt & kc.DEL,

  # Screenshot
  SCSH = tap.reg.mod.lgui & tap.reg.mod.lsft & kc.S,
} in

# The following keycode is a hold-tap, since it has a tap and a hold portion
# Important: All hold-taps need to have a behavior bound with `hold.reg.behavior`

let ctrl_if_held_and_space_if_tapped = 
  tap.reg.kc.SPC
  & hold.reg.mod.lctl
  & hold.reg.behavior {
    timeout_ms = 300
    # This will resolve as a hold after 300ms regardless of other keys pressed.
    # However, if released before the 300ms is up, it will resolve as a tap.
  }
in

# Keymap definition
{
  virtual_keys = [
    # Combo activated by the first and second physical keys
    combo.make 42 [0, 1],

    # Combo activated by the third, fourth, and fifth physical keys
    combo.make 69 [2, 3, 4],
  ],

  layers = [
    [ # Layer 0
      cu.COPY, cu.PSTE, 
      cu.CUT,  cu.":P",

      # Combos start here in the same order we defined them above
      hold.reg.layer 1,
      hold.reg.layer 2,
    ],
    [ # Layer 1
      kc.A,    kc.B,
      kc.D,    kc.E,

      TTTT,
      my_playback_tap_dance, 
    ],
    [ # Layer 2
      kc.N7,   kc.N8,
      kc.N4,   kc.N5,

      ctrl_if_held_and_space_if_tapped,
      TTTT,
    ],
  ]
}
