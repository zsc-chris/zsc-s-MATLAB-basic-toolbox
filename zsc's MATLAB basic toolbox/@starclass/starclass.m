classdef(HandleCompatible)starclass
%STARCLASS	Iterable unpacking (python style)
%	"star=STARCLASS;star{x,dim=1}" converts iterable x to comma-separated
%	list *x at dimensions dim. Dim can be [].
%
%	star{x,...} syntax support:
%	Reference(Statement&Assignment): [...]=fun(star{x,...});
%	Assignment: [star{"x",...}]=deal(...); % only work if quoted as string
%
%	flatten(star(...))'=={star{...}} is always satisfied.
%
%	The output can be further subsrefed/subsasgned without the need to use
%	cellfun. Be careful that the last subscript cannot be (), otherwise
%	evil MATLAB will force the numArgumentsFromSubscript to be 1. This is a
%	type of syntactic sugar for zsc's "xxxclass"es.
%
%	Note: If it weren't matlab.mixin.Scalar that does not allow you to
%		override subsref, starclass would be its subclass. Therefore, use
%		resize or repmat on starclass objects at your own risk.
%		Some funny results include: star{star} returns {1}, repmat(star,5)
%		returns {[1;1;1;1;1]}, repmat(star,[1,5]) returns {':'},
%		repmat(star,[5,1]) returns {[1;1;1;1;1]}
%	Note: In MATLAB® a dim-1 matrix should be [a;b;c;...]. [*x] is dim-2.
%	Note: As newvariable(1:3)=1 gives [1,1,1] (MATLAB sucks! paddata([],3)
%		gives [0;0;0], inconsistently)), star("newvariable(1:3)")={1,2,3}
%		and [star{"newvariable(1:3)"}]=deal(1,2,3) would error, while
%		star("newvariable(1:3,:)")={1,2,3} and
%		[star{"newvariable(1:3,:)"}]=deal(1,2,3) is the workaround.
%	Note: STARCLASS supports dnm, but only dimension index can be used.
%	Note: star{{...},...}{:} can be used to convert cell to comma seperated
%		list. This supports "{...}{:}" or "...(...){:}".
%	Note: star{...,[]}... allows for forbidden subsrefing like (...)(...).
%	Note: Make sure numArgumentsFromSubscript of evaluation result of the
%		string in assignment is 1.
%
%	Example:
%	>> star=STARCLASS;
%	>> star([1,2;3,4],1)
%
%	ans =
%
%	  2×1 cell array
%
%	    {2×1 double}
%	    {2×1 double}
%
%	>> ans{:}
%
%	ans =
%
%	     1
%	     2
%
%
%	ans =
%
%	     3
%	     4
%
%	>> star([1,2;3,4],2)
%
%	ans =
%
%	  2×1 cell array
%
%	    {2×1 double}
%	    {2×1 double}
%
%	>> ans{:}
%
%	ans =
%
%	     1
%	     3
%
%
%	ans =
%
%	     2
%	     4
%
%	>> a=struct(a={1,1;1,1})
%
%	a =
%
%	  2×2 struct array with fields:
%
%	    a
%
%	>> star{struct(a={1,2;3,4}),1}(2).a
%
%	ans =
%
%	     2
%
%
%	ans =
%
%	     4
%
%	>> a=[1,2;3,4];
%	>> star{a(1,:),[]}(1)
%
%	 ans =
%
%	      1
%
%	>> clear a
%	>> [star{"a(2:3,2:3)"}]=deal(struct(b=2));
%	>> a(2:3,2:3).b
%
%	ans =
%
%	     2
%
%
%	ans =
%
%	     2
%
%
%	ans =
%
%	     2
%
%
%	ans =
%
%	     2
%
%	>> [star{"a(1,:)"}.a]=deal(3);
%	>> a(1,:).a
%
%	ans =
%
%	     3
%
%
%	ans =
%
%	     3
%
%
%	ans =
%
%	     3
%
%	>> a=struct(a={1,2;3,4});
%	>> star("a",1:2).a={1,3;5,7};
%	>> a.a
%
%	ans =
%
%	     1
%
%
%	ans =
%
%	     5
%
%
%	ans =
%
%	     3
%
%
%	ans =
%
%	     7
%
%	See also deal, lists, dstarclass

%	Copyright 2024–2025 Chris H. Zhao
	methods(Hidden)
		ret=numArgumentsFromSubscript(self,s,indexingContext)
		% B=subsref(self,S)
		varargout=subsref(self,S)
		self=subsasgn(self,S,B)
	end
end