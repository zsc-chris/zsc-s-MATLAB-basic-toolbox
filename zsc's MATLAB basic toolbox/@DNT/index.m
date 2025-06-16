function ret=index(x,y)
%DNT.index	Convert dimension name to dimension number
%	ret=DNT.index(x,y), where x is dimension name entry and y is dimension
%	name query
%
%	Example:
%	>> DNT.index(["a","b"],["b","a","c","d"])
%
%	ans =
%
%	     2     1     3     4
%
%	>> DNT.index(["a","b"],["b","a","d","c"])
%
%	ans =
%
%	     2     1     4     3
%
%	Copyright 2025 Chris H. Zhao
	arguments
		x(1,:)string
		y(1,:)string
	end
	[~,ret]=ismember(y,x);
	out=outclass;
	ret(ret==0)=numel(x)+out{3,3,@unique,y(ret==0)};
end