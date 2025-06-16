%zsc's MATLAB basic toolbox	Utility toolbox to speed up MATLAB development
%	zsc's MATLAB basic toolbox provides one with user-friendly scripts for
%	MATLAB that enhances one's developing efficiency.
%
%	Note: The help documentation inside the toolbox follows the following
%	semantics: a(...,(*.../*),...), the first part contains required and
%	optional parameters, the second part repeating, and the third part
%	name-value.
%
%Classes:
%	DNT        - Dimension-named tensor
%	dotprivate - Reloaded "." subsref for private method
%	dstarclass - Mapping unpacking (python style)
%	outclass   - Captures designated output of function
%	starclass  - Iterable unpacking (python style)
%
%Functions:
%	broadcast       - Broadcast array to size
%	einsum          - Einstein summation
%	eqn             - Equal, treating NaNs as equal
%	fftconvn        - N-dimensional FFT convolution
%	flatten         - Flatten array
%	funcat          - Concatenate function output
%	getdiag         - Get diagonal element
%	ifinline        - Inline if (C-style)
%	isDNT           - True for a DNT
%	lg              - Common logarithm
%	ln              - Natural logarithm
%	minndims        - Minimal dimension number for a tensor
%	mod1            - Modulo in [1,divisor]
%	munit           - Matrix unit/one-hot matrix
%	mustBeTrue      - Validate that condition is true
%	neps            - Spacing of floating point numbers, zero-ward
%	nextreal        - Next real floating-point number
%	nop             - No operations
%	prevreal        - Previous real floating-point number
%	repr            - String representation of object
%	rethrowAsCaller - Rethrow as caller, hiding current layer
%	str2subs        - Convert string to substruct
%	succeeds        - Test if command is successful
%	ternary         - Ternary expression (vectorized)
%	tryinline       - Inline try
%
%Namespaces:
%	zsc - Enhanced MATLAB functions

%	Copyright 2025 Chris H. Zhao
%
%	Permission is hereby granted, free of charge, to any person obtaining a
%	copy of this software and associated documentation files (the
%	"Software"), to deal in the Software without restriction, including
%	without limitation the rights to use, copy, modify, merge, publish,
%	distribute, sublicense, and/or sell copies of the Software, and to
%	permit persons to whom the Software is furnished to do so, subject to
%	the following conditions:
%
%	The above copyright notice and this permission notice shall be included
%	in all copies or substantial portions of the Software.
%
%	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
%	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
%	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
%	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
%	CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
%	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
%	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.