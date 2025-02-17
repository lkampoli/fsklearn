Program pyf
    Implicit None
    Integer :: file_num = 7

    Open(7,file='pyf.py')
    write(file_num,'(A)') "import json"
    write(file_num,'(A)') "import numpy as np"
    write(file_num,'(A)') "from sklearn.neural_network import MLPRegressor"
    write(file_num,'(A)') "from sklearn.ensemble import RandomForestRegressor"
    write(file_num,'(A)') "from sklearn import tree"
    write(file_num,'(A)') "from sklearn.multioutput import MultiOutputRegressor"
    write(file_num,'(A)') "import os"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "def sk2f(write_paras):"
    write(file_num,'(A)') "    if (write_paras.type == 'Neural_Network'):"
    write(file_num,'(A)') "        nn_sk2f(write_paras)"
    write(file_num,'(A)') "    elif (write_paras.type == 'Random_Forest'):"
    write(file_num,'(A)') "        rf_sk2f(write_paras)"
    write(file_num,'(A)') "    elif (write_paras.type == 'Decision_Tree'):"
    write(file_num,'(A)') "        dt_sk2f(write_paras)"
    write(file_num,'(A)') "    else:"
    write(file_num,'(A)') "        print('wrong type')"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "def nn_sk2f(nn):"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "    file_name = 'nn_param.dat'"
    write(file_num,'(A)') "    nn_output  = open(nn.output_param_path+file_name, 'w')"
    write(file_num,'(A)') "    nn_output.write('! n_layers\n%d\n'%(nn.n_layers_))"
    write(file_num,'(A)') "    nn_output.write('! layer_sizes\n')"
    write(file_num,'(A)') "    nn_output.write('%d \n'%np.shape(nn.coefs_[0])[0])"
    write(file_num,'(A)') "    for i in range(len(nn.hidden_layer_sizes)):"
    write(file_num,'(A)') "        nn_output.write('%d '%nn.hidden_layer_sizes[i])"
    write(file_num,'(A)') "    nn_output.write('%d\n'%nn.n_outputs_)"
    write(file_num,'(A)') "    nn_output.write('! intercepts\n')"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "    for i in range(len(nn.intercepts_)):"
    write(file_num,'(A)') "        # somehow numpy seems to have some problem with 3x version in def function"
    write(file_num,'(A)') "        # np.savetxt(nn_output,np.intercepts_[i])"
    write(file_num,'(A)') "        for j in range(len(nn.intercepts_[i])):"
    write(file_num,'(A)') "            nn_output.write('%f '%nn.intercepts_[i][j])"
    write(file_num,'(A)') "        nn_output.write('\n')"
    write(file_num,'(A)') "    nn_output.write('! coefs\n')"
    write(file_num,'(A)') "    for i in range(len(nn.coefs_)):"
    write(file_num,'(A)') "        nn_output.write('!! layer%d\n'%i)"
    write(file_num,'(A)') "        # same numpy savetxt issue"
    write(file_num,'(A)') "        # np.savetxt(nn_output, np.transpose(nn.coefs_[i]))"
    write(file_num,'(A)') "        coef = np.transpose(nn.coefs_[i])"
    write(file_num,'(A)') "        for j in range(len(coef)):"
    write(file_num,'(A)') "            for k in range(len(coef[j])):"
    write(file_num,'(A)') "                nn_output.write('%f '%coef[j][k])"
    write(file_num,'(A)') "            nn_output.write('\n')"
    write(file_num,'(A)') "    nn_output.write('! activations\n')"
    write(file_num,'(A)') "    nn_output.write(nn.activation)"
    write(file_num,'(A)') "    nn_output.write('\n')"
    write(file_num,'(A)') "    nn_output.write('! out_activations\n')"
    write(file_num,'(A)') "    nn_output.write(nn.out_activation_)"
    write(file_num,'(A)') "    nn_output.write('\n')"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "def dt_sk2f(dt):"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "    dt_output = open(dt.output_param_path+'dt_param.dat','w')"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "    dt_output.write('! node_count\n')"
    write(file_num,'(A)') "    dt_output.write('%d\n'%dt.tree_.node_count)"
    write(file_num,'(A)') "    dt_output.write('! n_features\n')"
    write(file_num,'(A)') "    dt_output.write('%d\n'%dt.tree_.n_features)"
    write(file_num,'(A)') "    dt_output.write('! n_outputs\n')"
    write(file_num,'(A)') "    dt_output.write('%d\n'%dt.tree_.n_outputs)"
    write(file_num,'(A)') "    dt_output.write('! max_depth\n')"
    write(file_num,'(A)') "    dt_output.write('%d\n'%dt.tree_.max_depth)"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "    for i in range(dt.tree_.node_count):"
    write(file_num,'(A)') "        dt_output.write('! node %d\n'%(i+1))"
    write(file_num,'(A)') "        dt_output.write('%d\n'%(dt.tree_.children_left[i]+1))"
    write(file_num,'(A)') "        dt_output.write('%d\n'%(dt.tree_.children_right[i]+1))"
    write(file_num,'(A)') "        dt_output.write('%d\n'%(dt.tree_.feature[i]+1))"
    write(file_num,'(A)') "        dt_output.write('%f\n'%dt.tree_.threshold[i])"
    write(file_num,'(A)') "        for j in range(dt.tree_.n_outputs):"
    write(file_num,'(A)') "            dt_output.write('%f '%dt.tree_.value[i,j])"
    write(file_num,'(A)') "        dt_output.write('\n')"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "def rf_sk2f(rf):"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "    rf_output = open(rf.output_param_path+'rf_param.dat','w')"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "    rf_output.write('! tree_count\n')"
    write(file_num,'(A)') "    rf_output.write('%d\n'%len(rf.estimators_))"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "    trees = rf.estimators_"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "    for j in range(len(rf.estimators_)):"
    write(file_num,'(A)') "        tree1 = trees[j].tree_"
    write(file_num,'(A)') "        rf_output.write('! node_count\n')"
    write(file_num,'(A)') "        rf_output.write('%d\n'%tree1.node_count)"
    write(file_num,'(A)') "        rf_output.write('! n_features\n')"
    write(file_num,'(A)') "        rf_output.write('%d\n'%tree1.n_features)"
    write(file_num,'(A)') "        rf_output.write('! n_outputs\n')"
    write(file_num,'(A)') "        rf_output.write('%d\n'%tree1.n_outputs)"
    write(file_num,'(A)') "        rf_output.write('! max_depth\n')"
    write(file_num,'(A)') "        rf_output.write('%d\n'%tree1.max_depth)"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "        for i in range(tree1.node_count):"
    write(file_num,'(A)') "            rf_output.write('! node %d\n'%(i+1))"
    write(file_num,'(A)') "            rf_output.write('%d\n'%(tree1.children_left[i]+1))"
    write(file_num,'(A)') "            rf_output.write('%d\n'%(tree1.children_right[i]+1))"
    write(file_num,'(A)') "            rf_output.write('%d\n'%(tree1.feature[i]+1))"
    write(file_num,'(A)') "            rf_output.write('%f\n'%tree1.threshold[i])"
    write(file_num,'(A)') "            for j in range(tree1.n_outputs):"
    write(file_num,'(A)') "                rf_output.write('%f '%tree1.value[i,j])"
    write(file_num,'(A)') "            rf_output.write('\n')"
    write(file_num,'(A)') ""
    write(file_num,'(A)') ""
    write(file_num,'(A)') "for root, dirs, files in os.walk(""build""):"
    write(file_num,'(A)') "    for file in files:"
    write(file_num,'(A)') "        if file.endswith("".json""):"
    write(file_num,'(A)') "             json_f = os.path.join(root, file)"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "with open(json_f) as json_file:"
    write(file_num,'(A)') "    params = json.load(json_file)"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "T_data_path = params['data_path']"
    write(file_num,'(A)') "param_path = params['para_path']"
    write(file_num,'(A)') "training_type = params['training_type']"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "if 'num_mpi' in params.keys():"
    write(file_num,'(A)') "    T_input  = np.loadtxt(T_data_path+'training_input0.dat')"
    write(file_num,'(A)') "    T_output  = np.loadtxt(T_data_path+'training_output0.dat')"
    write(file_num,'(A)') "    for i in range(params['num_mpi']-1):"
    write(file_num,'(A)') "        file_name = T_data_path+'training_input' + str(i+1)+'.dat'"
    write(file_num,'(A)') "        file_name1 = T_data_path+'training_output' + str(i+1)+'.dat'"
    write(file_num,'(A)') "        T_input = np.append(T_input,np.loadtxt(file_name), axis=0)"
    write(file_num,'(A)') "        T_output = np.append(T_output,np.loadtxt(file_name1), axis=0)"
    write(file_num,'(A)') "else:"
    write(file_num,'(A)') "    T_input  = np.loadtxt(T_data_path+'training_input.dat')"
    write(file_num,'(A)') "    T_output  = np.loadtxt(T_data_path+'training_output.dat')"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "if (training_type == 'Neural_Network'):"
    write(file_num,'(A)') "    ml = MLPRegressor()"
    write(file_num,'(A)') "elif (training_type == 'Random_Forest'):"
    write(file_num,'(A)') "    ml = RandomForestRegressor()"
    write(file_num,'(A)') "elif (training_type == 'Decision_Tree'):"
    write(file_num,'(A)') "    ml = tree.DecisionTreeRegressor()"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "ml.fit(T_input, T_output)"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "ml.type = training_type"
    write(file_num,'(A)') "ml.output_param_path = param_path"
    write(file_num,'(A)') "sk2f(ml)"
    write(file_num,'(A)') ""
    write(file_num,'(A)') "print('-------------------------------\n')"
    write(file_num,'(A)') "print('training_completed\n\n')"
    write(file_num,'(A)') "print('training_type:\n')"
    write(file_num,'(A)') "print(training_type+'\n')"
    write(file_num,'(A)') "print('-------------------------------\n')"
End Program pyf
