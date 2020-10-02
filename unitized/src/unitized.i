%module unitized

namespace unitized {
  class Angle;
}

%{
#include "angle.h"
#include "length.h"
%}

%include "length.h"
%include "angle.h"
