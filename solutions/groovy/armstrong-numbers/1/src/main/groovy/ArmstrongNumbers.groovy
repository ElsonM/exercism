class ArmstrongNumber {

    static isArmstrongNumber(number) {
        def digits = number.toString().collect { it as int }
        def power = digits.size()

        def sum = digits.sum { digit ->
            digit ** power
        }

        return sum == number
    }

}