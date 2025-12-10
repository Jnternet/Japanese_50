use rand::seq::SliceRandom;
use rand::{rng, Rng};
pub mod api;

mod frb_generated;

const JAP_CHARS: [&str; 46] = [
    "あ-a", "い-i", "う-u", "え-e", "お-o", "か-ka", "き-ki", "く-ku", "け-ke", "こ-ko", "さ-sa",
    "し-si", "す-su", "せ-se", "そ-so", "た-ta", "ち-ti", "つ-tu", "て-te", "と-to", "な-na",
    "に-ni", "ぬ-nu", "ね-ne", "の-no", "は-ha", "ひ-hi", "ふ-hu", "へ-he", "ほ-ho", "ま-ma",
    "み-mi", "む-mu", "め-me", "も-mo", "や-ya", "ゆ-yu", "よ-yo", "ら-ra", "り-ri", "る-ru",
    "れ-re", "ろ-ro", "わ-wa", "を-wo", "ん-nn",
];
pub fn char_vec() -> Vec<String> {
    let mut jap_char_vec: Vec<String> = JAP_CHARS.iter().map(|&s| s.to_string()).collect();
    jap_char_vec.shuffle(&mut rng());
    jap_char_vec
}
pub fn split_jap_char(jap_char: String) -> (String, String) {
    let split_vec = jap_char.split("-").collect::<Vec<&str>>();
    let char_jap = split_vec[0].to_string();
    let char_spell = split_vec[1].to_string();

    (char_jap, char_spell)
}
pub fn get_jap_char(n: usize) -> (String, String) {
    let char = JAP_CHARS[n];
    let split_vec = char.split("-").collect::<Vec<&str>>();
    let char_jap = split_vec[0].to_string();
    let char_spell = split_vec[1].to_string();

    (char_jap, char_spell)
}
pub fn rand_0_45() -> usize {
    rng().random_range(0..=45)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_get_char() {
        assert_eq!(get_jap_char(0), ("あ".to_string(), "a".to_string()));
    }
}
