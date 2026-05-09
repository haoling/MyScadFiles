$fa = 0.1;
$fs = 0.1;

PITCH = 18;
w = 5;
rH = 7; // 仕切りレール高さ
rB = 2; // 仕切りレールの底面の厚み
pD = 10; // 柱の幅
// pH = 146; // 柱の高さ
pH = 20;
CONNECTOR_CIRCLE_WIDTH = 3; // メスコネクタの幅
CONNECTOR_DEPTH = 3; // メスコネクタの高さ方向の奥行き
CONNECTOR_ELLIPSE_LENGTH = 0.4; // 半円の下にどれくらいの直線区間を付けるか
mfDiff = 0.2; // メスコネクタの差し込み部分の余裕

PLATE_JOINT_SPRING_RADIUS = pD * 2; // プレートジョイントのバネの円の半径
PLATE_JOINT_SPRING_DEPTH = 1.2; // プレートジョイントのバネの厚み
PLATE_JOINT_SPRING_ARC_LENGTH = (pD * 1.5) - (mfDiff * 2); // プレートジョイントのバネの円弧長
PLATE_JOINT_SPRING_PILLAR_WIDTH = 2;
PLATE_JOINT_SPRING_LENGTH = (pD * 2) - (mfDiff * 2); // プレートジョイントのバネの全体の長さ

