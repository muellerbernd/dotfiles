import argparse


def parse_args():
    parser = argparse.ArgumentParser(description="helperscript for qmk led config")
    parser.add_argument("-r", "--row", help="row of key")
    parser.add_argument("-c", "--col", help="col of key")
    parser.add_argument("-nr", "--nr_rows", help="nr of rows")
    parser.add_argument("-nc", "--nr_cols", help="nr of cols")
    args, unknown = parser.parse_known_args()

    parser_extra = argparse.ArgumentParser(description="Extra arguments")
    for arg in unknown:
        if arg.startswith(("-", "--")):
            parser_extra.add_argument(arg)
    args_extra = parser_extra.parse_args(unknown)

    return args, vars(args_extra)


def main(args, extra_dict):
    nr_of_cols = int(args.nr_cols)
    nr_of_rows = int(args.nr_rows)
    col_pos = int(args.col)
    row_pos = int(args.row)
    x = 224 / (nr_of_cols - 1) * col_pos
    y = 64 / (nr_of_rows - 1) * row_pos
    print(f"x={int(x)}, y={int(y)}")
    phy_pos_to_index(x,y,nr_of_cols, nr_of_rows)

def phy_pos_to_index(x,y, nr_of_cols, nr_of_rows):
    col_pos = (x * (nr_of_cols -1)) / 224
    row_pos = (y * (nr_of_rows -1)) / 64
    print(f"for x={x}, y={y} -> r={row_pos}, c={col_pos}")


if __name__ == "__main__":
    args, extra_dict = parse_args()
    print(args)
    main(args, extra_dict)
    # phy_pos_to_index(x=85,y=16,nr_of_cols=6,nr_of_rows=4)
