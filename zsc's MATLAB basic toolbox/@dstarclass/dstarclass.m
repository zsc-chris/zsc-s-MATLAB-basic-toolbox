classdef(HandleCompatible)dstarclass
%DSTARCLASS	Mapping unpacking (python style)
%	"dstar=DSTARCLASS;dstar{x,numpairs}" converts mapping x to
%	comma-separated list **x, which is name-value pair. numpairs only
%	matters in {} assignment.
%
%	dstar{x} syntax support:
%	Statement: [...]=dstar{x};
%	Expression: [...]=fun(dstar{x});
%	Assignment: [dstar{"x",...}]=deal(...);
%
%	dstar(...) is equivalent to structured {dstar{...}}, i.e.
%	dstar{...}=="dstar(...){:}". Using this syntax eliminates the need to
%	specify numpairs.
%
%	{dstar{...}}==namedargs2cell(...) for struct input.
%
%	The output can be further subsrefed/subsasgned without the need to use
%	cellfun. Be careful that the last subscript cannot be (), otherwise
%	evil MATLAB will force the numArgumentsFromSubscript to be 1. This is a
%	type of syntactic sugar for zsc's "xxxclass"es.
%
%	Example:
%	>> dstar=DSTARCLASS;
%	>> dstar(struct(a=struct(a=1),b=struct(a=2)))
%
%	ans =
%
%	  2×2 cell array
%
%	    {["a"     ]}    {["b"     ]}
%	    {1×1 struct}    {1×1 struct}
%
%	>> dstar{struct(a=struct(a=1),b=struct(a=2))}.a
%
%	ans =
%
%	    "a"
%
%
%	ans =
%
%	     1
%
%
%	ans =
%
%	    "b"
%
%
%	ans =
%
%	     2
%
%	>> dstar("a(1)")={"a","b";1,2};
%	>> a
%
%	a =
%
%	  struct with fields:
%
%	    a: 1
%	    b: 2
%
%	>> [dstar{"a(2)",1}.a]=deal("b",5);
%	>> a
%
%	a =
%
%	  1×2 struct array with fields:
%
%	    a
%	    b
%
%	>> a(2).b.a
%
%	ans =
%
%	     5
%
%
%	See also deal, lists, starclass, namedargs2cell

%	Copyright 2024–2025 Chris H. Zhao
	methods
		ret=numArgumentsFromSubscript(self,s,indexingContext)
		% B=subsref(self,S)
		varargout=subsref(self,S)
		self=subsasgn(self,S,B)
	end
end