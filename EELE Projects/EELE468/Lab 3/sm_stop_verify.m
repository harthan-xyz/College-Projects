%% Verification
function mp = sm_stop_verify(mp)
% Verify that the test data got encoded, passed through the model, and
% decoded correctly. The input (modified by gain) and output values should
% be identical.
mp.left_error_max = max(abs(mp.test_signal.left-mp.left_data_out));
mp.right_error_max = max(abs(mp.test_signal.left-mp.right_data_out));
mp.precision = 2^(-mp.F_bits);
% display popup message
    strl = [' Max Left Error = ' num2str(mp.left_error_max) '\n Max Right Error = ' num2str(mp.right_error_max)];
    strl = [strl ' Max Left Error = ' num2str(mp.left_error_max) '\n Max right Error = ' num2str(mp.right_error_max)];
if (mp.left_error_max <= mp.precision) && (mp.right_error_max <= mp.precision)
    strl = [strl '\n Error is within acceptable range \n Least significant bit precision (F_bits = ' num2str(mp.F_bits) ') is ' num2str(2^(-mp.F_bits))];
    helpdlg(sprintf(strl), 'Verification Message: Passed')    
else    
    strl = [strl '\n ERROR is **NOT** within acceptable range \n Least significant bit precision (F_bits = ' num2str(mp.F_bits) ') is ' num2str(2^(-mp.F_bits))];
    helpdlg(sprintf(strl), 'Verification Message: Failed')
end
