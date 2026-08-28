class Pangram {

    static boolean isPangram(String sentence) {
        def letters = sentence.toLowerCase().findAll { it >= 'a' && it <= 'z' }
        return letters.toSet().size() == 26
    }

}