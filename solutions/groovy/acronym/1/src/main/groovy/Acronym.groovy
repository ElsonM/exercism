class Acronym {

    static String abbreviate(String phrase) {
        StringBuilder acronym = new StringBuilder();
        String[] words = phrase.replace('-', ' ').split("\\s+");

        for (String word : words) {
            word = word.replaceAll("[^A-Za-z]", "");

            if (!word.isEmpty()) {
                acronym.append(word.charAt(0));
            }
        }

        return acronym.toString().toUpperCase();
    }

}