classdef outclass
%OUTCLASS	Captures designated output of function
%	"out=OUTCLASS;out{n,i,f,*args}" outputs the i-th output of f(*args) out
%	of n requested as a comma-separated list.
%
%	"out=OUTCLASS;out(n,i,f,*args)" outputs the i-th output of f(*args) out
%	of n requested as a cell with the same size as i.
%
%	flatten(out(...))'=={out{...}} is always satisfied.
%
%	The output can be further subsrefed without the need to use cellfun. Be
%	careful that the last subscript cannot be (), otherwise evil MATLAB
%	will force the numArgumentsFromSubscript to be 1. This is a type of
%	syntactic sugar for zsc's "xxxclass"es.
%
%	Example:
%	>> out=OUTCLASS;
%	>> out{4,3:4,@deal,1,2,3,4}
%
%	ans =
%
%	     3
%
%
%	ans =
%
%	     4
%
%	>> out(4,[1,2;3,4],@deal,1,2,3,4)
%
%	ans =
%
%	  2×2 cell array
%
%	    {[1]}    {[2]}
%	    {[3]}    {[4]}
%
%	See also deal, lists

%	Copyright 2024 Chris H. Zhao
	methods
		function ret=numArgumentsFromSubscript(self,s,indexingContext)
			arguments
				self outclass
				s(:,1)struct
				indexingContext(1,1)matlab.indexing.IndexingContext
			end
			switch s(1).type
				case "."
					ret=builtin("numArgumentsFromSubscript",self,s,indexingContext);
				case "{}"
					ret=numel(s(1).subs{2});
				case "()"
					if isscalar(s)
						ret=1;
					else
						ret=numArgumentsFromSubscript(subsref(self,s(1)),s(2:end),indexingContext);
					end
			end
		end
		function varargout=subsref(self,S)
			arguments
				self outclass
				S(:,1)struct
			end
			if S(1).type=="."
				varargout={builtin("subsref",self,S)};
			else
				varargout=cell(1,S(1).subs{1});
				[varargout{:}]=S(1).subs{3}(S(1).subs{4:end});
				varargout=varargout(S(1).subs{2});
				if ~isscalar(S)
					varargout=cellfun(@(x)subsref(x,S(2:end)),varargout,UniformOutput=false);
				end
				if S(1).type=="()"
					varargout={varargout};
				end
			end
		end
	end
end