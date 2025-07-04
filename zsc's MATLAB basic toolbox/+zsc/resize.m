function B=resize(A,m,options)
%zsc.resize	Improved version of MATLAB RESIZE
%	B=zsc.resize(A,m,*,Dimension="auto",FillValue=[],Pattern="constant",
%	Side="trailing") doesn't deem isequal(size(A),[0,0]) as a special case,
%	and works if Dimension is empty.
%
%	See also resize, zsc.paddata

%	Copyright 2025 Chris H. Zhao
	arguments
		A
		m(1,:){mustBeInteger,mustBeNonnegative}
		options.Dimension(1,:){mustBeTrue("@(m,Dimension)succeeds(@()assert(startsWith(""auto"",Dimension)))||succeeds(@()assert(all(Dimension>0)&&succeeds(@()mustBeInteger(Dimension))&&(isscalar(m)||numel(m)==numel(Dimension))&&numel(Dimension)==numel(unique(Dimension))))",m,options.Dimension,VariableNames=["m","options.Dimension"])}="auto"
		options.FillValue(1,1)
		options.Pattern(1,1)string{mustBeMember(options.Pattern,["constant","edge","circular","flip","reflect"])}
		options.Side(1,1)string{mustBeMember(options.Side,["trailing","leading","both"])}="trailing"
	end
	zsc.assert(~all(isfield(options,["FillValue","Pattern"])),message("MATLAB:resize:PatternAndFillValue"))
	if isempty(options.Dimension)||isempty(m)
		B=A;
		return
	end
	if ~istable(A)&&isequal(size(A),[0,0])
		sz=size(A);
		if isequal(options.Dimension,"auto")
			options.Dimension=1:numel(m);
		end
		sz(numel(sz)+1:max(options.Dimension))=1;
		sz(options.Dimension)=m;
		if isfield(options,"FillValue")
			B=createArray(sz,Like=A,FillValue=options.FillValue);
		else
			B=createArray(sz,Like=A);
		end
	else
		dstar=dstarclass;
		B=resize(A,m,dstar{options});
	end
end