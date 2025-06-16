function [S,M]=std(A,w,dims,missingflag)
%zsc.std	Improved version of MATLAB STD
%	[S,M]=std(A,w=[],dims=paddata(find(size(A)~=1),1,FillValue=1),
%	missingflag="includemissing") returns nan when operating on dimension
%	with only one nonmissing element and w==0.
%
%	See also std

%	Copyright 2025 Chris H. Zhao
	arguments
		A
		w{mustBeNumeric}=[]
		dims(1,:){mustBeTrue("@(dims)succeeds(@()mustBeInteger(dims))&&all(dims>0)||succeeds(@()assert(string(dims)==""all""))",dims,VariableNames="dims")}=paddata(find(size(A)~=1),1,FillValue=1)
		missingflag(1,1)string{mustBeMember(missingflag,["includemissing","includenan","includenat","omitmissing","omitnan","omitnat"])}="includemissing"
	end
	if isequal(w,[])
		w=0;
	end
	[S,M]=std(A,w,dims,missingflag);
	if isequal(w,0)
		if contains(missingflag,"omit")
			S(sum(~ismissing(A),dims)==1)=nan;
		else
			if prod(size(A,dims))==1
				S=nan(size(S),like=S);
			end
		end
	end
end