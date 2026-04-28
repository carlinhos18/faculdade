teaches(adalberto, algorithms).
teaches(bernardete, databases).
teaches(capitolino, compilers).
teaches(diogenes, statistics).
teaches(ermelinda, networks).
attends(alberto, algorithms).
attends(bruna, algorithms).
attends(cristina, algorithms).
attends(diogo, algorithms).
attends(eduarda, algorithms).
attends(antonio, databases).
attends(bruno, databases).
attends(cristina, databases).
attends(duarte, databases).
attends(eduardo, databases).
attends(alberto, compilers).
attends(bernardo, compilers).
attends(clara, compilers).
attends(diana, compilers).
attends(eurico, compilers).
attends(antonio, statistics).
attends(bruna, statistics).
attends(claudio, statistics).
attends(duarte, statistics).
attends(eva, statistics).
attends(alvaro, networks).
attends(beatriz, networks).
attends(claudio, networks).
attends(diana, networks).
attends(eduardo, networks).

x_student_y(X, Y) :- (attends(X, Z), teaches(Y, Z)).
students_x(Professor, Aluno) :- (teaches(Professor, Cadeira), attends(Aluno, Cadeira)).
teachers_x(Aluno, Professor) :- (attends(Aluno, Cadeira), teaches(Professor, Cadeira)).
student_both(Aluno, Professor1, Professor2) :- (attends(Aluno, Cadeira1), teaches(Professor1, Cadeira1), teaches(Professor2, Cadeira2), attends(Aluno, Cadeira2)).
coleagues(Aluno1, Aluno2) :- (attends(Aluno1, Cadeiras), attends(Aluno2, Cadeiras)).