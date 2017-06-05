CXX = g++
CXXFLAGS = -std=c++11

OBJECTS = best_time_to_meet.o
DEPENDS =  ${OBJECTS:.o=.d}
EXEC = best_time_to_meet

all: ${EXEC}

${EXEC}: ${OBJECTS}
	${CXX} ${CXXFLAGS} -o ${EXEC}

.PHONY : all clean
.DEFAULT: all

clean:
	rm -rf ${DEPENDS} ${OBJECTS} ${EXECS}

-include ${DEPENDS}
