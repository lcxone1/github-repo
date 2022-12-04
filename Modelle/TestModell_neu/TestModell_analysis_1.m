function TestModell_analysis_1(instance,varargin)
    % TestModell_analysis_1 Example Analysis Function

	if instance.isComponent()
		Basic_Latency = instance.getValue("Basic.Latency");
		Komponent_Aufstartszeit = instance.getValue("Komponent.Aufstartszeit");
		Komponent_CPU_Resourcen = instance.getValue("Komponent.CPU_Resourcen");
		Komponent_Latency = instance.getValue("Basic.Latency");
		if isempty(instance.Components)
		else
		end
	elseif instance.isPort()
		Basic_Latency = instance.getValue("Basic.Latency");
	elseif instance.isConnector()
		Basic_Latency = instance.getValue("Basic.Latency");
	end
end
