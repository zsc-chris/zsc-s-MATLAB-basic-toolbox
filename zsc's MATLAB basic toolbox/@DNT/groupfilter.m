function [DNTs,BG]=groupfilter(DNTs,groupvars,method)
%GROUPFILTER	Filter data by group
%	[DNTs,BG]=GROUPFILTER(DNTs,groupvars,method) filters DNTs by
%	group defined by groupvars along its dimension using method.
%	DNTs                 - {*DNTs}
%	groupvars            - DNT
%		Will be broadcast against DNTs along groupvars.dimnames.
%	method               - function_handle scalar
%		Inputs to method are DNTs containing a flattened dimension named
%		flatten(groupvars.dimnames) along with other dimensions untouched.
%		method should reduce all dimensions.
%
%	Note: Groupbins and options related to it, as well as non-scalar
%		groupvars, are not supported. Use findgroups and discretize first.
%	Note: Do not use string as dtype for groupvars. Otherwise it may
%		interfere with chaotic evil arguments system of MATLAB.
%
%	Example:
%	>> [DNTs,BG]=groupfilter({DNT([1,2;3,4;5,6],["a","b"]),DNT([1,2;5,6;3,4],["a","b"])},DNT([1,1,2],"a"),@(x,y)size(x,"a")>1)
%
%	DNTs =
%
%	  1×2 cell array
%
%	    {2×2 DNT}    {2×2 DNT}
%
%
%	BG =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              1
%	    2              1
%
%	>> DNTs{:}
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              3    4
%
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              1    2
%	    2              5    6
%
%	See also groupfilter, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		DNTs(1,:)cell
		groupvars DNT
		method(1,1){mustBeA(method,["string","function_handle"])}
	end
	arguments(Output)
		DNTs(1,:)cell
		BG DNT
	end
	constructor=str2func(class(groupvars));
	if isscalar(groupvars)
		groupvars=constructor(groupvars,DNT.gennewdims(numel(unique(zsc.cell2mat(cellfun(@(x)x.dimnames,DNTs,UniformOutput=false))))+1));
	end
	star=starclass;
	[tmp{1:numel(DNTs)+1}]=feval(@deal,star{cellfun(@(DNT)subsasgn(DNT,substruct(".","dimnames","()",{~ismember(DNT.dimnames,groupvars.dimnames)}),missing),[DNTs,{groupvars}],UniformOutput=false),2}{:});
	tmp=tmp{1};
	out=outclass;
	[DNTs{:},groupvars]=star{cellfun(@(DNT)out{2,1,@(varargin)feval(@deal,varargin{:}),DNT,tmp},[DNTs,{groupvars}],UniformOutput=false),2}{:};
	clear tmp
	dims=groupvars.dimnames;
	DNTs=cellfun(@(x)flatten(x,dims),DNTs,UniformOutput=false);
	DNTs_=DNTs;
	dim=DNT.catdims(dims);
	DNTs=cellfun(@(x)flatten(gather(num2cell(x,setdiff(x.dimnames,dim)))),DNTs,UniformOutput=false);
	groupvars=flatten(groupvars);
	DNTs=num2cell([DNTs{:}],2);
	function ret=method_(DNTs)
		DNTs=cellfun(@(x)cat(dim,x{:}),num2cell(zsc.cell2mat(DNTs),1),UniformOutput=false);
		ret=method(DNTs{:});
	end
	[DNTs,BG]=groupfilter(DNTs,gather(groupvars),@method_);
	if isempty(DNTs)
		DNTs=cellfun(@(x)repmat(x,dim,0),DNTs_,UniformOutput=false);
	else
		DNTs=cellfun(@(x)cat(dim,x{:}),num2cell(zsc.cell2mat(DNTs),1),UniformOutput=false);
	end
	BG=constructor(BG,DNT.catdims(dims));
end