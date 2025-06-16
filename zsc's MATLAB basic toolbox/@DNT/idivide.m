function ret=idivide(self,other,opt)
%IDIVIDE	Integer division with rounding option
%	ret=IDIVIDE(self,other,opt="fix")
%
%	See also idivide, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		other DNT
		opt(1,1)string{mustBeMember(opt,["fix","floor","ceil","round"])}="fix"
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@idivide,self,other,AdditionalInput={opt});
end