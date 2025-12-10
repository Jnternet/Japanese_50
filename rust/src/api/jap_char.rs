use crate::char_vec as _char_vec;
use crate::get_jap_char as _get_jap_char;
use crate::rand_0_45 as _rand_0_45;
use crate::split_jap_char as _split_jap_char;
use flutter_rust_bridge::frb;

#[frb(sync)]
pub fn get_jap_char(index: usize) -> (String, String) {
    _get_jap_char(index)
}

#[frb(sync)]
pub fn rand_0_45() -> usize {
    _rand_0_45()
}

#[frb(sync)]
pub fn char_vec() -> Vec<String> {
    _char_vec()
}

#[frb(sync)]
pub fn split_jap_char(jap_char: String) -> (String, String) {
    _split_jap_char(jap_char)
}
