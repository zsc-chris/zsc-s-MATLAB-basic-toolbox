function [ret,L,RP,RU]=corrcoef(self,other,dims,options)
%CORRCOEF	Correlation coefficients
%	[ret,L,RP,RU]=CORRCOEF(self,other,
%	dims=union(self.dimnames,other.dimnames),*,Alpha=0.05,Row="all")
%	calculates pairwise correlation coefficient along dims.
%
%	Example:
%	>> [a,b]=deal(DNT([1,2;3,4],["a","b"]),DNT([3,1;4,2],["a","b"]));
%	>> CORRCOEF(a,b,"a")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              1.0000
%	    2              1.0000
%
%	>> CORRCOEF(a,b,"b")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              -1.0000
%	    2              -1.0000
%
%	See also corrcoef, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		other DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		options.Alpha(1,1)double=0.05
		options.Row(1,1)string{mustBeMember(options.Row,["all","complete","pairwise"])}="all"
	end
	arguments(Output)
		ret DNT
		L DNT
		RP DNT
		RU DNT
	end
	dstar=dstarclass;
	[ret,L,RP,RU]=fevalalong(@corrcoef_,dims,self,other,Mode="flattenall",KeepOtherDims=true,UnflattenOther=1,BroadcastSizeDims="all",AdditionalInput={dstar{options}});
end
function [ret,L,RP,RU]=corrcoef_(self,other,options)
	arguments(Input)
		self
		other
		options.Alpha(1,1)double=0.05
		options.Row(1,1)string{mustBeMember(options.Row,["all","complete","pairwise"])}="all"
	end
	tmp=[self,other];
	if size(tmp,1)==1
		[ret,L,RP,RU]=deal(nan(size(self),like=self));
		return
	end
	star=starclass;
	dstar=dstarclass;
	[ret,L,RP,RU]=corrcoef(tmp,dstar{options});
	[ret,L,RP,RU]=star{cellfun(@(x)diag(x(end/2+1:end,1:end/2))',{ret;L;RP;RU},UniformOutput=false)}{:};
end