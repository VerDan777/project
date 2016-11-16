package {
	public class CMathExt {
		public static function InterLineSqr(p1, p2, p3, r) {
			var res = [];
			var x1 = p3.x-r;
			var x2 = p3.x+r;
			var y1 = p3.y-r;
			var y2 = p3.y+r;
			var dx = p1.x-p2.x;
			var dy = p1.y-p2.y;
			var dd = dx*dx+dy*dy;
			//
			//if ((p1.x>x1 && p1.x<x2) || (p2.x>x1 && p2.x<x2) || (p1.x<x1 && p2.x>x2) || (p2.x<x1 && p1.x>x2) || (p1.y>y1 && p1.y<y2) || (p2.y>y1 && p2.y<y2) || (p1.y<x1 && p2.y>y2) || (p2.y<x1 && p1.y>y2)) {
			//if ((p1.y>y1 && p1.y<y2) || (p2.y>y1 && p2.y<y2) || (p1.y<x1 && p2.y>y2) || (p2.y<x1 && p1.y>y2)) {
			var inter;
			inter = InterLineLine(p1, p2, {x:x1, y:y1}, {x:x1, y:y2});
			if (inter)
				res.push(inter);
			
			inter = InterLineLine(p1, p2, {x:x1, y:y1}, {x:x2, y:y1});
			if (inter)
				res.push(inter);
			
			inter = InterLineLine(p1, p2, {x:x2, y:y2}, {x:x2, y:y1});
			if (inter)
				res.push(inter);
			
			inter = InterLineLine(p1, p2, {x:x2, y:y2}, {x:x1, y:y2});
			if (inter)
				res.push(inter);
			
			//}   
			//}
			return res;
		}
		public static function InterLineLine(p1, p2, p3, p4) {
			var distAB, theCos, theSin, newX, ABpos;
			//  Fail if either line segment is zero-length.
			var Ax, Ay, Bx, By, Cx, Cy, Dx, Dy;
			Ax = p1.x;
			Ay = p1.y;
			Bx = p2.x;
			By = p2.y;
			Cx = p3.x;
			Cy = p3.y;
			Dx = p4.x;
			Dy = p4.y;
			//  Fail if either line segment is zero-length.
			if (Ax == Bx && Ay == By || Cx == Dx && Cy == Dy) {
				return null
			}
			//  Fail if the segments share an end-point.                  
			if (Ax == Cx && Ay == Cy || Bx == Cx && By == Cy || Ax == Dx && Ay == Dy || Bx == Dx && By == Dy) {
				return null
			}
			//  (1) Translate the system so that point A is on the origin.                  
			Bx -= Ax;
			By -= Ay;
			Cx -= Ax;
			Cy -= Ay;
			Dx -= Ax;
			Dy -= Ay;
			//  Discover the length of segment A-B.
			distAB = Math.sqrt(Bx*Bx+By*By);
			//  (2) Rotate the system so that point B is on the positive X axis.
			theCos = Bx/distAB;
			theSin = By/distAB;
			newX = Cx*theCos+Cy*theSin;
			Cy = Cy*theCos-Cx*theSin;
			Cx = newX;
			newX = Dx*theCos+Dy*theSin;
			Dy = Dy*theCos-Dx*theSin;
			Dx = newX;
			//  Fail if segment C-D doesn't cross line A-B.
			if (Cy<0 && Dy<0 || Cy>=0 && Dy>=0) {
				return null
			}
			//  (3) Discover the position of the intersection point along line A-B.                  
			ABpos = Dx+(Cx-Dx)*Dy/(Dy-Cy);
			//  Fail if segment C-D crosses line A-B outside of segment A-B.
			if (ABpos<0 || ABpos>distAB) {
				return null
			}
			//  (4) Apply the discovered position to line A-B in the original coordinate system.                  
			var oX = Ax+ABpos*theCos;
			var oY = Ay+ABpos*theSin;
			//  Success.
			return {x:oX, y:oY};
			//return true
		}
		public static function InterRayCir(p1, p2, sc, sc_r) {
			var EPS = 0.00000001;
			var dp = {};
			//
			dp.x = p2.x-p1.x;
			dp.y = p2.y-p1.y;
			var a = dp.x*dp.x+dp.y*dp.y;
			if (Math.abs(a)<EPS) {
				return null;
			}
			var b = 2*(dp.x*(p1.x-sc.x)+dp.y*(p1.y-sc.y));
			var c = sc.x*sc.x+sc.y*sc.y;
			c += p1.x*p1.x+p1.y*p1.y;
			c -= 2*(sc.x*p1.x+sc.y*p1.y);
			c -= sc_r*sc_r;
			var bb4ac = b*b-4*a*c;
			if (bb4ac<0) {
				return null;
			} else {
				var mu1 = (-b+Math.sqrt(bb4ac))/(2*a);
				var mu2 = (-b-Math.sqrt(bb4ac))/(2*a);
				//p = p1 + mu1 (p2 - p1)
				var r1 = {};
				r1.x = p1.x+mu1*(p2.x-p1.x);
				r1.y = p1.y+mu1*(p2.y-p1.y);
				if (mu1 === mu2) {
					return [r1];
				} else {
					var r2 = {};
					r2.x = p1.x+mu2*(p2.x-p1.x);
					r2.y = p1.y+mu2*(p2.y-p1.y);
					return [r1,r2];
				}
			}
		}
	}
}