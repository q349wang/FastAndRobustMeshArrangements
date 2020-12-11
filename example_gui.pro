TEMPLATE        = app
TARGET          = mesh_intersections
QT              += core opengl
CONFIG          += c++11
CONFIG          -= app_bundle
CXXFLAGS        ="-mmacosx-version-min=10.14"
CONFIG          += sdk_no_version_check
DEFINES         += CINOLIB_USES_OPENGL
DEFINES         += CINOLIB_USES_QT
QMAKE_CXXFLAGS  += -Wno-deprecated-declarations # gluQuadric gluSphere and gluCylinde are deprecated in macOS 10.9
DATA_PATH       = \\\"$$PWD/data/\\\"
DEFINES         += DATA_PATH=$$DATA_PATH

DEFINES         += IS64BITPLATFORM
DEFINES         += CINOLIB_USES_EXACT_PREDICATES


SOURCES         +=  main.cpp \
                    external/Cinolib/external/predicates/shewchuk.c \
                    external/IndirectPredicates/implicit_point.cpp \
                    external/IndirectPredicates/numerics.cpp \
                    external/IndirectPredicates/predicates/indirect_predicates.cpp \


# PROJECT CODE
INCLUDEPATH     += code

#INDIRECT PREDICATES
INCLUDEPATH     += external/IndirectPredicates/predicates
INCLUDEPATH     += external/IndirectPredicates

#EIGEN
INCLUDEPATH     += external/Cinolib/external/eigen

# CINOLIB
INCLUDEPATH     += external/Cinolib/include

unix:macx{

QMAKE_CXXFLAGS -= -O
QMAKE_CXXFLAGS -= -O1
QMAKE_CXXFLAGS -= -O2
QMAKE_CXXFLAGS -= -O3
QMAKE_CXXFLAGS += -O0
}


# just for Linux
unix:!macx{

QMAKE_CXXFLAGS  += -frounding-math


# for cinolib
DEFINES += GL_GLEXT_PROTOTYPES
LIBS    += -lGLU

#parallel version
#QMAKE_CXXFLAGS  += -fopenmp
#QMAKE_LFLAGS    += -fopenmp


}



#DEFINES += NDEBUG




