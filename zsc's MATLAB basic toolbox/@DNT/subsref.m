function B=subsref(self,S)
%SUBSREF	Subscripted reference
%	Syntax: *...=...[.(...)/(...)/{...}]*? allows you to group dimensions
%
%	. Usage: properties & methods of self are priortized over properties /
%		fields / methods of gather(self)
%
%	() Usage: Supports these syntax:%
%		...(dim1={sub1,sub2},dim1={...},dim1=indn2ndims,dim2=sub2,...)...->
%			Each sub (if not cell, convert to cell) will be grouped by cat
%			according to the provided dimension, and subs in a group, if
%			not a DNT, will be converted to DNT using the 1, 2, ...,
%			n–ndims (the ndims of the group). If sub is ':' it will be
%			replaced with (1:end)' before broadcasting. If sub is logical
%			it will be find-ed before broadcasting. Then arrays within a
%			group will be broadcast against each other and sub2ind-ed.
%			Dimensions not referenced will be filled with ':'.
%
%		...(sub1,sub2,...,indn2ndims)...->same as
%			...(DNT.catdims(self.dimnames),{sub1,sub2,...,indn2ndims}), see
%			above
%
%		...(ind(1,1)struct/dictionary/table(dim1=sub1,dim2=sub2))...->First
%			dstar{ind}, and then same as the above semantics.
%
%		You may use ...(...,newdim1=':',newdim2=':',...) to add dimensions,
%		although in most cases this is unnecessary.
%
%	{} Usage: Same as (), but for dtype=cell. See starclass if you want to
%		unzip.
%
%	Using a×b as reference will prioritize a×b over a and b if they
%	all exist in dimension.
%
%	Example:
%	>> [aind,cind]=ndgrid(DNT(1:2,"a"),DNT(1:2,"c"));
%	>> [bind,dind]=ndgrid(DNT(1:2,"b"),DNT(1:2,"d"));
%	>> a=DNT(reshape(1:16,2,2,2,2),["a","b","c","d"]);
%	>> a(aind,bind,cind,dind)
%	>> all(a(aind,bind,cind,dind)==a)
%
%	ans =
%
%	  DNT logical scalar
%
%	   1
%
%	>> all(a("a×c",{aind,cind},"b×d",{bind,dind})==a)
%
%	ans =
%
%	  DNT logical scalar
%
%	   1
%
%	Note: To input ×, install powertoys, press-and-hold x and press space,
%	press ← key, and finally release x. I am sorry that this is annoying.
%
%	See also DNT/subsasgn, DNT/ndgrid, starclass

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		S(:,1)struct
	end
	arguments(Output,Repeating)
		B
	end
	constructor=str2func(class(self));
	if S(1).type=="."
		if zsc.isproperty("DNT",S(1).subs)||zsc.ismethod("DNT",S(1).subs)||zsc.ismethod("DNT",S(1).subs,false)&&zsc.ismethod("DNT",S(1).subs+"_")
			[B{1:nargout}]=subsref@dotprivate(self,S);
		else
			[B{1:nargout}]=subsref(gather(self),S);
		end
	else
		star=starclass;
		[~,subs]=parsedimargsindexing(self,S(1).subs,"subsref");
		if isempty(subs)
			B={self};
			return
		end
		for i=1:size(subs,2)
			if ~ismembern(subs{1,i},[self.dimnames,missing])
				self=flatten(self,DNT.splitdim(subs{1,i}));
			end
		end
		dims=zsc.cell2mat(subs(1,:));
		S(1).subs=arrayfun(@(dim)ifinline(ismembern(dim,dims),@()subs{2,eqn(dim,dims)},@()':'),[self.dimnames,missing],UniformOutput=false);
		newsize=[star{arrayfun(@(dim)ifinline(ismembern(dim,dims),@()subs{3,eqn(dim,dims)},@()size(self,dim)),[self.dimnames,missing],UniformOutput=false),2}{:}];
		newdimnames=[star{arrayfun(@(dim)ifinline(ismembern(dim,dims),@()DNT.splitdim(dim,numel(subs{3,eqn(dim,dims)})),@()dim),[self.dimnames,missing],UniformOutput=false),2}{:}];
		if S(1).type=="()"
			[B{1:nargout}]=zsc.subsref(constructor(reshape(subsref(gather(self),S(1)),paddata(newsize,[1,2],FillValue=1)),newdimnames),S(2:end));
		else
			[B{1:nargout}]=subsref(gather(self),S);
			if ~ismember("{}",cellfun(@(x)string(x),{S.type}))&&~ismember(".",cellfun(@(x)string(x),{S.type}))
				B=cellfun(@(x)constructor(reshape(x,paddata(newsize,[1,2],FillValue=1)),newdimnames),B,UniformOutput=false);
			end
		end
	end
end