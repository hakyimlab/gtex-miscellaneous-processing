
* `model_training_eqtl.yaml` trains prediction models on expression using Elastic Net algorithm.
* `model_training_eqtl_repeat.yaml` is like the previous one, with a larger number of nested cv loops.
* `model_training_eqtl_dap_linear.yaml` trains OLS models on variants filtered by DAPG PIP values.
* `model_training_eqtl_dapgw.yaml` trains prediction models, using Elastic Net, on variants filtered by DAPG PIP, using PIP as penalty weights 
(i.e. more likely varians are less penalized)
* `model_training_eqtl_dapgw.yaml` is like the previous one, restricted to hapmap variants


`regress_eqtl.yaml` will regress covariates out of expression traits. 

Log checking scripts are provided (`check_log_model_training*`) to see if all jobs finished successfully, and to parswe execution wrapups.