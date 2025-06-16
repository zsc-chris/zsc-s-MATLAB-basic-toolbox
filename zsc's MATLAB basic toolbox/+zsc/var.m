function [V,M]=var(A,w,dims,nanflag)
%zsc.var	Improved version of MATLAB VAR
%	[V,M]=var(A,w=[],dims=paddata(find(size(A)~=1),1,FillValue=1),
%	nanflag="includemissing") returns nan when operating on dimension
%	with only one nonmissing element and w==0.
%
%	See also var

%	Copyright 2025 Chris H. Zhao
	arguments
		A
		w{mustBeNumeric}=[]
		dims(1,:){mustBeTrue("@(dims)succeeds(@()mustBeInteger(dims))&&all(dims>0)||succeeds(@()assert(string(dims)==""all""))",dims,VariableNames="dims")}=paddata(find(size(A)~=1),1,FillValue=1)
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="includemissing"
	end
	if isequal(w,[])
		w=0;
	end
	[V,M]=var(A,w,dims,nanflag);
	if isequal(w,0)
		if contains(nanflag,"omit")
			V(sum(~ismissing(A),dims)==1)=nan;
		else
			if prod(size(A,dims))==1
				V=nan(size(V),like=V);
			end
		end
	end
end