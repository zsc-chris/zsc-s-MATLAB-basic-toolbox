function DNTs=applykernel(self,kernel,kernelind,options)
%APPLYKERNEL	Eval a kernel function on a DNT
%	*DNTs=APPLYKERNEL(self,kernel,kernelind,**options) is the same as
%	*DNTs=fevalkernel(kernel,kernelind,self,**options).
%
%	See also DNT/fevalkernel

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		kernel(1,1)function_handle
		kernelind(1,:)cell
		options.Mode(1,1)string{mustBeMember(options.Mode,["ind","dist"])}="ind"
		options.FillValue(1,1)=missing
		options.Pattern(1,1)string{mustBeMember(options.Pattern,["constant","edge","circular","flip","reflect"])}="constant"
		options.Endpoints(1,:){mustBeTrue("@(Endpoints)isscalar(Endpoints)&&isnumeric(Endpoints)||succeeds(@()assert(ismember(string(Endpoints),[""shrink"",""discard"",""fill""])))",options.Endpoints,VariableNames="Endpoints")}="shrink"
		options.SamplePoints(1,:){mustBeA(options.SamplePoints,["numeric","cell"])}
		options.Vectorized(1,1)=true
		options.AdditionalInput(1,:)cell={}
	end
	arguments(Output,Repeating)
		DNTs DNT
	end
	dstar=dstarclass;
	[DNTs{1:nargout}]=fevalkernel(kernel,kernelind,self,dstar{options});
end