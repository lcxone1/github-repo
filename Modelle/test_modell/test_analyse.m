function test_analyse(instance,varargin)
    % test_modell_analysis Example Analysis Function
    sys_latenz = 0;
    % Calculate total latenz
	if instance.isComponent() % && ~isempty(instance.Components) && instance.hasValue('Komponent.Latency')
        

        for child = instance.Components
            if child.hasValue('Komponent.Latency')
                comp_latenz = child.getValue('Komponent.Latency');
           sys_latenz = sys_latenz + comp_latenz;
            end
        end

% 	elseif instance.isConnector() && ~isempty(instance.Connector)...
%  && instance.hasValue('TestProfile.Konnector.Latency')
% 
%         for child = instance.Connector
%             if child.hasValue('TestProfile.Konnector.Latency')
%                 conn_latenz = child.getValue('TestProfile.Konnector.Latency');
%            sys_latenz = sys_latenz + conn_latenz;
%             end
%         end
		
    end

    instance.setValue('Komponent.Latency',sys_latenz);
end
