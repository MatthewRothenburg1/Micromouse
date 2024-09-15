classdef CircularBuffer < matlab.System
    % CircularBuffer Circular Buffer for a signal
    %
    % This class implements a circular buffer using the MATLAB System
    % framework, allowing integration with Simulink.

    %#codegen
    
    properties (Nontunable)
        BufferLength = 10; % Length of the buffer
    end
    
    properties
        InitialCondition = 0; % Initial condition for the buffer
    end
    
    properties(Access = private)
        Buffer; % Persistent buffer
    end
    
    methods(Access = protected)
        
        function setupImpl(obj)
            % Initialize the buffer during the first call
            if isequal(numel(obj.InitialCondition), obj.BufferLength)
                obj.Buffer = obj.InitialCondition;
            elseif isscalar(obj.InitialCondition)
                obj.Buffer = obj.InitialCondition * ones(1, obj.BufferLength);
            else
                error('InitialCondition must either be scalar or the same dimensions as BufferLength');
            end
        end
        
        function out = stepImpl(obj, signal)
            % Output the current state of the buffer
            out = obj.Buffer;
            
            % Update the buffer
            obj.Buffer = [signal, obj.Buffer(1:end-1)];
        end
        
        function resetImpl(obj)
            % Reset the buffer to initial condition
            
        end
        
    end
    
    methods(Access = protected)
        function num = getNumInputsImpl(~)
            num = 1; % Number of inputs
        end
        
        function num = getNumOutputsImpl(~)
            num = 1; % Number of outputs
        end
    end
end
