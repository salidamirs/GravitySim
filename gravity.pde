// Gravity algorithm
// Blank for now
void gravity() {
  for (Particle p : particles) {
    gravitate(p, root);
  }
}

Vector gravityForce(Vector a, Vector b, float m_a, float m_b) {
  if (a.equals(b)) return new Vector(0, 0);
  //REALISTIC return mult(sub(a, b), G * m_b / (distSquared(a, b) * (float) Math.sqrt(distSquared(a, b) + 1)));
  return mult(sub(a, b), G * m_b / (distSquared(a, b)));
}

void gravitate(Particle p, TreeNode tn) {
  if (tn.leaf) {
    if (tn.particle == null || p == tn.particle) return;
    p.vel.add(gravityForce(tn.particle.pos, p.pos, mass, mass));
    return;
  }

  if (tn.center == null) { tn.center = mult(tn.totalCenter, 1.0f / tn.count); }
  if (tn.w / dist(p.pos, tn.center) < theta) {
    p.vel.add(gravityForce(tn.center, p.pos, mass, tn.totalMass));
    return;
  }

  for (TreeNode child : tn.children) gravitate(p, child);
}