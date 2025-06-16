function [DNTs,BG]=grouptransform(DNTs,groupvars,method)
%GROUPTRANSFORM	Transformations by group
%	[DNTs,BG]=GROUPTRANSFORM(DNTs,groupvars,method) transforms DNTs by
%	group defined by groupvars along its dimension using method.
%	DNTs                 - {*DNTs}
%	groupvars            - DNT
%		Will be broadcast against DNTs along groupvars.dimnames.
%	method               - function_handle scalar
%		Inputs to method are DNTs containing a flattened dimension named
%		flatten(groupvars.dimnames) along with other dimensions untouched.
%		method should transform the flattened dimension without changing
%		size along it, whether other dimensions are affected or not.
%		nargout(method) must be specified via zsc.function_handle/funcat.
%
%	Note: Groupbins and options related to it, as well as non-scalar
%		groupvars, are not supported. Use findgroups and discretize first.
%
%	Example:
%	>> [DNTs,BG]=GROUPTRANSFORM({DNT([1,2;3,4;5,6],["a","b"]),DNT([1,2;5,6;3,4],["a","b"])},DNT(1,"a"),funcat(@(x,y)x+y,@(x,y)x./y))
%
%	DNTs =
%
%	  1×2 cell array
%
%	    {3×2 DNT}    {3×2 DNT}
%
%
%	BG =
%
%	  3 DNT double vector
%
%
%	    a
%
%	    1              1
%	    2              1
%	    3              1
%
%	>> DNTs{:}
%
%	ans =
%
%	  3×2 DNT double matrix
%
%	         b          1     2
%	    a
%
%	    1               2     4
%	    2               8    10
%	    3               8    10
%
%
%	ans =
%
%	  3×2 DNT double matrix
%
%	         b              1         2
%	    a
%
%	    1                   1         1
%	    2              0.6000    0.6667
%	    3              1.6667    1.5000
%
%	See also grouptransform, DNT

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
	dim=DNT.catdims(dims);
	DNTs=cellfun(@(x)flatten(gather(num2cell(x,setdiff(x.dimnames,dim)))),DNTs,UniformOutput=false);
	[groupvars,~,sz]=flatten(groupvars);
	DNTs=num2cell([DNTs{:}],2);
	function DNTs=method_(DNTs)
		DNTs=cellfun(@(x)cat(dim,x{:}),num2cell(zsc.cell2mat(DNTs),1),UniformOutput=false);
		[tmp{1:nargout(method)}]=method(DNTs{:});
		DNTs=tmp;
		DNTs=cellfun(@(x)flatten(gather(num2cell(x,setdiff(x.dimnames,dim)))),DNTs,UniformOutput=false);
		DNTs=num2cell([DNTs{:}],2);
	end
	[DNTs,BG]=grouptransform(DNTs,gather(groupvars),@method_);
	DNTs=cellfun(@(x)cat(dim,x{:}),num2cell(zsc.cell2mat(DNTs),1),UniformOutput=false);
	DNTs=cellfun(@(x)unflatten(x,dim,sz),DNTs,UniformOutput=false);
	BG=unflatten(constructor(BG,DNT.catdims(dims)),dim,sz);
end