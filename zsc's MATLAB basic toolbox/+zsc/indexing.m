function ret=indexing(input,subs,options)
%zsc.indexing	Improved version of MATLAB INDEXING
%	ret=zsc.indexing(input,{*subs},*,FillValue=missing,Pattern="constant")
%	uses python-style indexing, and allows for extrapolation. FillValue and
%	Pattern has the same meaning as those in paddata/resize, except that
%	the two are not mutually exclusive, and FillValue is only considered if
%	Pattern=="constant"
%
%	Example:
%	>> zsc.indexing([1,2;3,4],{[1;2;3],[1;1;1]},pattern="circular")
%
%	ans =
%
%	     1
%	     3
%	     1
%
%	See also paddata, resize

%	Copyright 2025 Chris H. Zhao
	arguments
		input
		subs(1,:)cell{mustBeTrue("@(subs)isscalar(unique(cellfun(@(x)keyHash(size(x)),subs)))",subs,VariableNames="subs"),mustBeTrue("@(input,subs)numel(subs)>=minndims(input)",input,subs,VariableNames=["input","subs"])}
		options.FillValue(1,1)=missing
		options.Pattern(1,1)string{mustBeMember(options.Pattern,["constant","edge","circular","flip","reflect"])}="constant"
	end
	sz=size(subs{1});
	subs=cellfun(@(x)x(:),subs,UniformOutput=false);
	switch options.Pattern
		case "constant"
			invalid=any(cell2mat(subs)>size(input,1:numel(subs)),2)|any(cell2mat(subs)<ones([1,numel(subs)]),2);
			subs=arrayfun(@(x,i)clip(x{1},1,size(input,i)),subs,1:numel(subs),UniformOutput=false);
		case "edge"
			subs=arrayfun(@(x,i)clip(x{1},1,size(input,i)),subs,1:numel(subs),UniformOutput=false);
		case "circular"
			subs=arrayfun(@(x,i)mod1(x{1},size(input,i)),subs,1:numel(subs),UniformOutput=false);
		case "flip"
			subs=arrayfun(@(x,i)feval(@(x)ifinline(x<=size(input,i),@()x,@()size(input,i)*2+1-x),mod1(x{1},size(input,i)*2)),subs,1:numel(subs),UniformOutput=false);
		case "reflect"
			subs=arrayfun(@(x,i)ternary(size(input,i)>1,feval(@(x)ternary(x<=size(input,i),x,size(input,i)*2-1-x),mod1(x{1},size(input,i)*2-2)),ones("like",x{1})),subs,1:numel(subs),UniformOutput=false);
	end
	ret=input(sub2ind(size(input),subs{:}));
	if options.Pattern=="constant"
		ret(invalid)=options.FillValue;
	end
	ret=reshape(ret,sz);
end