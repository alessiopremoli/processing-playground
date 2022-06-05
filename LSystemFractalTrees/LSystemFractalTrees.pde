String axiom;
String sentence, nextSentence;
float len = 100;
float angle;

boolean horizontal = true;
static final int PUSHES = 256;

Rule[] rules;

void setup() {
    size(1920, 1080);
    background(25, 25, 25);
    angle = radians(25);

    axiom = xenakisTreeAxiom;
    rules = xenakisTree;
    sentence = axiom;

    turtle();
}

void draw() {}

void generate() {
    // len *= 0.5;
    nextSentence = "";
    for (int i = 0; i < sentence.length(); i++) {
        String current = str(sentence.charAt(i));
        boolean transformed = false;
        for (int j = 0; j < rules.length; j++) {
            if (current.equals(rules[j].input)) {
                nextSentence += rules[j].output;
                transformed = true;
            }
        }
        if (!transformed) {
            nextSentence += current;
        }
    }
    sentence = nextSentence;
    background(25, 25, 25);
}

void turtle() {
    println(sentence);
    background(25, 25, 25);
    stroke(255);
    resetMatrix();

    if (horizontal) {
        translate(0, height / 2);
        rotate(radians(90));
    } else {
        translate(width / 2, height);
    }  

    for (int i = 0; i < sentence.length(); i++) {
        String current = str(sentence.charAt(i));
        if (current.equals("F")) {
            line(0, 0, 0, -width);
            translate(0, -len);
        } else if (current.equals("+")) {
            //angle = radians(random(25, 45));
            rotate(angle);
        } else if (current.equals("-")) {
            //angle = radians(random(25, 45));
            rotate(-angle);
        } else if (current.equals("[")) {
            push();
        } else if (current.equals("]")) {
            pop();
        }
    }
}

void mouseClicked() {
    generate();
    turtle();
}
