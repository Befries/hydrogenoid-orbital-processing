class Polynom {
  
  
  // indice associé à son exposants, si une puissance n'est pas là alors sont coefficient est nul sauf si
  // la puissance est plus grande que le maximum (implicite)
  // carte d'identité du polynome
  private double[] coeff;
  
  
  // classe pour manipuler des polynômes
  public Polynom(double[] coeff) {
    this.coeff = coeff;
  }
  
  
  // évalue le polynome au point x
  public double evaluateAt(double x) {
    double res = 0;
    for (int i = 0; i < coeff.length; i++) res += coeff[i] * Math.pow(x, i);
    return res;
  }
  
  
  // change ce polynome directement: mult par un scalaire
  public void scalarMult(double s) {
    for (int i = 0; i < coeff.length; i++) coeff[i] *= s;
  }
  
  
  // renvoie ce polynome multiplié par un scalaire
  public Polynom getScalarMult(double s) {
    Polynom res = this.copy();
    res.scalarMult(s);
    return res;
  }
  
  
  // renvoie l'addition des deux polynômes
  public Polynom getAddition(Polynom other) {
    double otherCoeff[] = other.getCoefficient();
    double newCoeff[];
    if (other.degree() > this.degree()) {
      newCoeff = other.getCoefficient();
      for (int i = 0; i < coeff.length; i++) newCoeff[i] += coeff[i];
      return new Polynom(newCoeff);
    }
    newCoeff = this.getCoefficient();
    for (int i = 0; i < other.degree() + 1; i++) newCoeff[i] = otherCoeff[i];
    return new Polynom(newCoeff);
  }
  
  
  // renvoie un le polynome résultat de la multiplication
  public Polynom getMultiplication(Polynom other) {
    double[] otherCoeff = other.getCoefficient();
    double[] newCoeff = new double[coeff.length + other.degree()];
    for (int i = 0; i < coeff.length; i++) {
      for (int j = 0; j < otherCoeff.length; j++) {
        int l = i + j;
        newCoeff[l] += coeff[i] * otherCoeff[j];
      }
    }
    return new Polynom(newCoeff);
  }
  
  
  // renvoie la puissance n de ce polynome
  public Polynom getPow(int n) {
    if (n == 0) {
      double[] r = {1};
      return new Polynom(r);
    }
    Polynom res = this.copy();
    for (int i = 1; i < n; i++) res = res.getMultiplication(this);
    return res;
  }
  
  
  // renvoie le Polynome qui est sa dérivé
  public Polynom getDerivative() {
    double[] newCoeff = new double[degree()];
    for (int i = 0; i < degree(); i++) newCoeff[i] = coeff[i + 1] * (i + 1);
    return new Polynom(newCoeff);
  }
  
  // renvoie la dérivé n ième
  public Polynom getNDerivative(int n) {
    Polynom res = this.copy();
    for (int i = 0; i < n; i++) res = res.getDerivative();
    return res;
  }
  
  
  // multiplication par x^-alpha si un terme devient une fraction de x alors il devient disparait
  public Polynom getReduced(int alpha) {
    double[] newCoeff = new double[coeff.length - alpha];
    for (int i = alpha; i < coeff.length; i++) newCoeff[i - alpha] = coeff[i];
    return new Polynom(newCoeff);
  }
  
  // considère une opération du type: e^x * d^n(e^-x * P(x))/dx^n
  // vous inquiétez pas c'est la bonne manière de le faire
  public Polynom getNMExpDerivative(int n) {
    Polynom res = this.copy();
    for (int i = 0; i < n; i++) {
      Polynom d = res.getDerivative();
      res = d.getAddition(res.getScalarMult(-1));
    }
      return res;
  }
  
  
  //retourne la liste des coefficients
  public double[] getCoefficient() {
    return coeff.clone();
  }
  
  // le degré du polynome
  public int degree() {
    return coeff.length - 1;
  }
  
  
  // écrit le polynome proprement
  public String toString() {
    String res = "" + coeff[0];
    for (int i = 1; i < coeff.length; i++) res += " + " + coeff[i] + " x^" + i;
    return res;
  }
  
  // renvoie une copie du polynome
  public Polynom copy() {
    return new Polynom(coeff.clone());
  }
  
}
