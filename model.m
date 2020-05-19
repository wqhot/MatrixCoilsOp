function out=model(coilsMatrix)

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath(['E:\wq\aaa']);
model.comments(['aaa']);

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.component('comp1').mesh.create('mesh1');

model.component('comp1').physics.create('mf', 'InductionCurrents', 'geom1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').activate('mf', true);

global LbtwUD;
xianquanW=0.005;
% model.component('comp1').geom('geom1').create('cyl1', 'Cylinder');
% model.component('comp1').geom('geom1').feature('cyl1').set('pos', [0 0 0.1]);
% model.component('comp1').geom('geom1').feature('cyl1').set('h', 0.001);
% model.component('comp1').geom('geom1').feature('cyl1').set('r', 0.6);
% model.component('comp1').geom('geom1').run('cyl1');
% model.component('comp1').geom('geom1').create('cyl2', 'Cylinder');
% model.component('comp1').geom('geom1').feature('cyl2').set('pos', [0 0 -0.101]);
% model.component('comp1').geom('geom1').feature('cyl2').set('h', 0.001);
% model.component('comp1').geom('geom1').feature('cyl2').set('r', 0.6);
% model.component('comp1').geom('geom1').run('cyl2');
for i=1:size(coilsMatrix,1)/2
    
    name=['cyl',num2str((i-1)*2+3)];
    model.component('comp1').geom('geom1').create(name, 'Cylinder');
    model.component('comp1').geom('geom1').feature(name).set('pos', [coilsMatrix(i,3) coilsMatrix(i,4) 0.1-xianquanW]);
    model.component('comp1').geom('geom1').feature(name).set('h', xianquanW);
    model.component('comp1').geom('geom1').feature(name).set('r', coilsMatrix(i,5));
    model.component('comp1').geom('geom1').feature(name).label(name);
    model.component('comp1').geom('geom1').run(name);

    name=['cyl',num2str((i-1)*2+4)];
    model.component('comp1').geom('geom1').create(name, 'Cylinder');
    model.component('comp1').geom('geom1').feature(name).set('pos', [coilsMatrix(i,3) coilsMatrix(i,4) 0.1-xianquanW]);
    model.component('comp1').geom('geom1').feature(name).set('h', xianquanW);
    model.component('comp1').geom('geom1').feature(name).set('r', coilsMatrix(i,5)-xianquanW);
    model.component('comp1').geom('geom1').feature(name).label(name);
    model.component('comp1').geom('geom1').run(name);

    name=['dif',num2str(i)];
    model.component('comp1').geom('geom1').create(name, 'Difference');
    model.component('comp1').geom('geom1').feature(name).selection('input').init;
    model.component('comp1').geom('geom1').feature(name).selection('input2').init;
    model.component('comp1').geom('geom1').feature(name).selection('input').set({['cyl',num2str((i-1)*2+3)]});
    model.component('comp1').geom('geom1').feature(name).selection('input2').set({['cyl',num2str((i-1)*2+4)]});
    model.component('comp1').geom('geom1').feature(name).label(['coil',num2str(i)]);
    model.component('comp1').geom('geom1').run(name);

    name=['cyl',num2str((i-1)*2+3+size(coilsMatrix,1))];
    model.component('comp1').geom('geom1').create(name, 'Cylinder');
    model.component('comp1').geom('geom1').feature(name).set('pos', [coilsMatrix(i,3) coilsMatrix(i,4) -0.1]);
    model.component('comp1').geom('geom1').feature(name).set('h', xianquanW);
    model.component('comp1').geom('geom1').feature(name).set('r', coilsMatrix(i,5));
    model.component('comp1').geom('geom1').feature(name).label(name);
    model.component('comp1').geom('geom1').run(name);

    name=['cyl',num2str((i-1)*2+4+size(coilsMatrix,1))];
    model.component('comp1').geom('geom1').create(name, 'Cylinder');
    model.component('comp1').geom('geom1').feature(name).set('pos', [coilsMatrix(i,3) coilsMatrix(i,4) -0.1]);
    model.component('comp1').geom('geom1').feature(name).set('h', xianquanW);
    model.component('comp1').geom('geom1').feature(name).set('r', coilsMatrix(i,5)-xianquanW);
    model.component('comp1').geom('geom1').feature(name).label(name);
    model.component('comp1').geom('geom1').run(name);

    name=['dif',num2str((i)+size(coilsMatrix,1)/2)];
    model.component('comp1').geom('geom1').create(name, 'Difference');
    model.component('comp1').geom('geom1').feature(name).selection('input').init;
    model.component('comp1').geom('geom1').feature(name).selection('input2').init;
    model.component('comp1').geom('geom1').feature(name).selection('input').set({['cyl',num2str((i-1)*2+3+size(coilsMatrix,1))]});
    model.component('comp1').geom('geom1').feature(name).selection('input2').set({['cyl',num2str((i-1)*2+4+size(coilsMatrix,1))]});
    model.component('comp1').geom('geom1').feature(name).label(['coil',num2str(i)+size(coilsMatrix,1)/2]);
    model.component('comp1').geom('geom1').run(name);

    
end
model.component('comp1').geom('geom1').create('sph1', 'Sphere');
model.component('comp1').geom('geom1').feature('sph1').set('r', 0.05);
%model.component('comp1').selection.create('sph1', 'Explicit');
model.component('comp1').geom('geom1').run('sph1');

% % model.component('comp1').material.create('mat1', 'Common');
% % model.component('comp1').material('mat1').label('Copper');
% % model.component('comp1').material('mat1').set('family', 'copper');
% % model.component('comp1').material('mat1').propertyGroup('def').set('relpermeability', '1');
% % model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', '5.998e7[S/m]');
% % model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', '1');
% % model.component('comp1').material('mat1').set('family', 'copper');
% % model.component('comp1').material('mat1').selection.set([1]);
% % 
% 
model.component('comp1').geom('geom1').run;
model.label(['pingbantidu' '.mph']);


model.component('comp1').physics('mf').create('coil1', 'Coil', 3);
model.component('comp1').physics('mf').feature('coil1').selection.set([12]);
model.component('comp1').physics('mf').feature('coil1').set('ConductorModel', 'Multi');
model.component('comp1').physics('mf').feature('coil1').set('CoilType', 'Linear');
model.component('comp1').physics('mf').feature('coil1').setIndex('materialType', 'from_mat', 0);
%mphsave(out,'bbb');
out = model;

