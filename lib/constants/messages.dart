
const String errorMessageFullName = "Invalid Name: Must be at least 3 characters in length";
const String errorMessageEmailAddress = "Invalid Email Address";
const String errorMessagePrimaryPassword = "Password must be at least 8 characters in length and contain at least one uppercase letter, lowercase letter, digit, and special character (!, %, @, #, \\, \$, &, *, or ~)";
const String errorMessageSecondaryPassword = "Password Mismatch";


RegExp emailRegularExpression = RegExp(r"^[a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+(\.[a-zA-Z0-9_-]+)*@[^-][a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,5})$");
RegExp passwordRegularExpression = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!%@#\$&*~]).{8,}$');