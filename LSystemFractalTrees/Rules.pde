class Rule {
  String input;
  String output;
  
  Rule(String in, String out) {
    input = in;
    output = out;
  }
}


Rule[] fractalTree = {
  new Rule("F", "FF+[+F-F-F]-[-F+F+F]")
};

String fractalTreeAxioM = "F";

Rule[] complexFractalTree = {
  new Rule("F", "FF"),
  new Rule("X", "F-[[X]+X]+F[+FX]-X")
};

String complexFractalTreeAxiom = "X";

// len *= 0.8;
Rule[] fractalBush = {
  new Rule("F", "F+[F-F-F]-[-F+F+F]")
};

String fractalBushAxiom = "F";


Rule[] myFractalTree = {
  new Rule("F", "F+[+F]-[-F]-[-F]+[FF]")
};

String myFractalTreeAxiom = "F";
