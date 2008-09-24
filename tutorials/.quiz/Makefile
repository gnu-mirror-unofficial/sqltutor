PROG=quiz

all: $(PROG)

$(PROG) : $(PROG).cpp Makefile
	$(CXX) $(CXXFLAGS) -o $@ $<

test:
	./$(PROG) filmy.quiz
