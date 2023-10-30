// The 'linear_regression' program.
program linear_regression.aleo {
    transition fit_transition(
        x1: i128,
        x2: i128,
        x3: i128,
        x4: i128,
        x5: i128,
        y1: i128,
        y2: i128,
        y3: i128,
        y4: i128,
        y5: i128,
        z1: i128,
        z2: i128,
        z3: i128,
        z4: i128,
        z5: i128
    ) -> (i128, i128, i128) {
        return fit(
            x1,
            x2,
            x3,
            x4,
            x5,
            y1,
            y2,
            y3,
            y4,
            y5,
            z1,
            z2,
            z3,
            z4,
            z5
        );
    }

    inline fit(
        x1: i128,
        x2: i128,
        x3: i128,
        x4: i128,
        x5: i128,
        y1: i128,
        y2: i128,
        y3: i128,
        y4: i128,
        y5: i128,
        z1: i128,
        z2: i128,
        z3: i128,
        z4: i128,
        z5: i128
    ) -> (i128, i128, i128) {
        let sum_x: i128 = x1 + x2 + x3 + x4 + x5;
        let sum_y: i128 = y1 + y2 + y3 + y4 + y5;
        let sum_z: i128 = z1 + z2 + z3 + z4 + z5;
        let sum_xy: i128 = x1 * y1 + x2 * y2 + x3 * y3 + x4 * y4 + x5 * y5;
        let sum_xz: i128 = x1 * z1 + x2 * z2 + x3 * z3 + x4 * z4 + x5 * z5;
        let sum_yz: i128 = y1 * z1 + y2 * z2 + y3 * z3 + y4 * z4 + y5 * z5;
        let sum_xx: i128 = x1 * x1 + x2 * x2 + x3 * x3 + x4 * x4 + x5 * x5;
        let sum_yy: i128 = y1 * y1 + y2 * y2 + y3 * y3 + y4 * y4 + y5 * y5;

        let determinant: i128 = 5i128 * (sum_xx * sum_yy - sum_xy * sum_xy) - sum_x * (sum_x * sum_yy - sum_xy * sum_y) + sum_y * (sum_x * sum_xy - sum_xx * sum_y);
        let determinant1: i128 = sum_z * (sum_xx * sum_yy - sum_xy * sum_xy) - sum_x * (sum_xz * sum_yy - sum_xy * sum_yz) + sum_y * (sum_xz * sum_xy - sum_xx * sum_yz);
        let determinant2: i128 = 5i128 * (sum_xz * sum_yy - sum_xy * sum_yz) - sum_z * (sum_x * sum_yy - sum_xy * sum_y) + sum_y * (sum_x * sum_yz - sum_xz * sum_y);
        let determinant3: i128 = 5i128 * (sum_xx * sum_yz - sum_xz * sum_xy) - sum_x * (sum_x * sum_yz - sum_xz * sum_y) + sum_z * (sum_x * sum_xy - sum_xx * sum_y);

        return (determinant1 / determinant, determinant2 / determinant, determinant3 / determinant);
    }

    transition predict_transition(
        x: i128,
        y: i128,
        a: i128,
        b1: i128,
        b2: i128
    ) -> i128 {
        return predict(
            x, 
            y, 
            a, 
            b1, 
            b2
        );
    }

    inline predict(
        x: i128,
        y: i128,
        a: i128,
        b1: i128,
        b2: i128
    ) -> i128 {
        return a + b1 * x + b2 * y;
    }

    transition fit_predict_transition(
        x1: i128,
        x2: i128,
        x3: i128,
        x4: i128,
        x5: i128,
        y1: i128,
        y2: i128,
        y3: i128,
        y4: i128,
        y5: i128,
        z1: i128,
        z2: i128,
        z3: i128,
        z4: i128,
        z5: i128
    ) -> (i128, i128, i128, i128, i128) {
        return fit_predict(
            x1,
            x2,
            x3,
            x4,
            x5,
            y1,
            y2,
            y3,
            y4,
            y5,
            z1,
            z2,
            z3,
            z4,
            z5
        );
    }

    inline fit_predict(
        x1: i128,
        x2: i128,
        x3: i128,
        x4: i128,
        x5: i128,
        y1: i128,
        y2: i128,
        y3: i128,
        y4: i128,
        y5: i128,
        z1: i128,
        z2: i128,
        z3: i128,
        z4: i128,
        z5: i128
    ) -> (i128, i128, i128, i128, i128) {
        let (a, b1, b2): (i128, i128, i128) = fit(
            x1,
            x2,
            x3,
            x4,
            x5,
            y1,
            y2,
            y3,
            y4,
            y5,
            z1,
            z2,
            z3,
            z4,
            z5
        );
        return (
            predict(x1, y1, a, b1, b2),
            predict(x2, y2, a, b1, b2),
            predict(x3, y3, a, b1, b2),
            predict(x4, y4, a, b1, b2),
            predict(x5, y5, a, b1, b2)
        );
    }
}
