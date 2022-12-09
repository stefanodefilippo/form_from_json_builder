import 'package:expression_language/expression_language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils{

  static bool parseConditionalExpression(String expression, Map<String, dynamic> args){

    for (String key in args.keys) {
      if(expression.contains(key)){
        expression = expression.replaceAll(key, args[key]!);
      }
    }

    String sanitzedExpression = sanitizeExpression(expression);

    ExpressionGrammarParser expressionGrammarParser = ExpressionGrammarParser({});
    var parser = expressionGrammarParser.build();
    var result;
    bool value = false;

    try {
      result = parser.parse(sanitzedExpression);
      Expression expressionParsed = result.value as Expression;
      value = expressionParsed.evaluate();
    } catch (e) {
      return false;
    }

    return value;

  }

  static persistStringValue(String key, String value) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString((key), value.toString());

  }

  static Future<String?> getStoredStringValue(String key) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);

  }

  static persistBoolValue(String key, bool value) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool((key), value);

  }

  static Future<bool?> getStoredBoolValue(String key) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);

  }

  static String sanitizeExpression(String expression) {

    List<String> splitted = expression.split(" ");
    for (int i = 0; i < splitted.length; i++) {
      if(!isNumeric(splitted[i]) && !isBooleanOperator(splitted[i]) && !isBooleanValue(splitted[i])){
        splitted[i] = "\"" + splitted[i] + "\"";
      }
    }
    return splitted.join();

  }

  static bool isNumeric(String str) {
    try{
      double.parse(str);
    } on FormatException {
      return false;
    }
    return true;
  }

  static bool isBooleanOperator(String element) {

    return element == ">=" || element == ">" || element == "<=" || element == "<" || element == "==" || element == "&&" || element == "||" || element == "!" || element == "&&" ||
        element == "+" || element == "-" || element == "*" || element == "/" || element == "~/" || element == "%";

  }

  static bool isBooleanValue(String element) {

    return element == "true" || element == "false";

  }



}