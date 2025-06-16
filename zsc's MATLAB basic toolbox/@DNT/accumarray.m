function ret=accumarray(ind,self,sz,fun,fillval,issparse)
%ACCUMARRAY	Construct a DNT by accumulation
%	ret=ACCUMARRAY(ind,self,sz=[],fun=@sum,fillval=[],issparse=false)
%	ind     - {*arrays/*DNTs/**arrays/**DNTs/mapping}
%		If ind is not cell, ind={ind} will be called before processing.
%		ind operates on a new DNT, so if ind is not {**arrays/**DNTs},
%		can only use x, x', ... in indexing. Same as subsref syntax.
%	self    - DNT
%	sz      - {*sz} or {**sz} or {sz,dim}
%		If ind is not cell, ind={ind} will be called before processing.
%	fun     - function_handle
%		Input to fun has a flattened dimension with other dimensions
%		untouched. It doesn't matter to squeeze or not.
%	fillval - scalar
%		fillval will be broadcast along other dimensions.
%
%	Note: issparse is not supported. It can only be false.
%	Note: Accumarray, like subsasgn, does not support renaming dimensions.
%		Rename dimensions (if you want) after accumarray.
%
%	Example:
%	>> ACCUMARRAY({"a",{DNT([1,1],"a")}},DNT([1,2;3,4],["a","b"]),[],@(x)sum(x,"a"))
%
%	ans =
%
%	  1×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              4    6
%
%	See also accumarray, DNT/subsref

%	Copyright 2025 Chris H. Zhao
	arguments
		ind{mustBeA(ind,["cell","DNT","numeric","struct","table","dictionary"])}
		self DNT
		sz{mustBeA(sz,["cell","numeric","struct","table","dictionary"])}=[]
		fun{mustBeTrue("@(fun)isequal(fun,[])||isa(fun,""function_handle"")",fun,VariableNames="fun")}=@sum
		fillval=[]
		issparse(1,1)logical{mustBeTrue("@(issparse)~issparse",issparse,VariableNames="issparse")}=false
	end
	constructor=str2func(class(self));
	if ~iscell(ind)
		ind={ind};
	end
	[new,~]=parsedimargsindexing(DNT,ind,"subsasgn");
	if isequal(sz,[])
		sz={size(new),new.dimnames};
	end
	if ~iscell(sz)
		sz={sz};
	end
	if isequal(fun,[])
		fun=@sum;
	end
	if isequal(fillval,[])
		fillval=constructor(createArray([1,1],Like=gather(self)));
	else
		fillval=constructor(fillval);
	end
	sz=parsedimargs(new.dimnames,sz);
	new=paddata(new,zsc.cell2mat(sz(2,:)),Dimension=zsc.cell2mat(sz(1,:)));
	ind_=constructor(zsc.reshape(1:numel(new),size(new)),new.dimnames);
	ind=subsref(ind_,substruct("()",ind));
	[self,~]=feval(@deal,self,ind);
	ind=flatten(gather(ind));
	[self,dim]=flatten(self,new.dimnames);
	star=starclass;
	self=gather(star(self,DNT.index(self.dimnames,dim)));
	ret=accumarray(ind,(1:numel(self))',[numel(new),1],@(x){x});
	ret=cellfun(@(x)ifinline(isequal(x,[]),@(){fillval},@(){fun(cat(dim,self{x}))}),ret);
	ret=constructor(zsc.reshape(ret,size(new)),new.dimnames);
	ret=cell2mat(ret);
end