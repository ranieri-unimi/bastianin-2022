yy = {'Y1': 1984,
 'Y2': 1988,
 'Y3': 1992,
 'Y4': 1996,
 'Y5': 2000,
 'Y6': 2004,
 'Y7': 2008,
 'Y8': 2012,
 'Y9': 2016,
 'Y10': 2020}

ss = {'S1': 'ALABAMA',
 'S2': 'ALASKA',
 'S3': 'ARIZONA',
 'S4': 'ARKANSAS',
 'S5': 'CALIFORNIA',
 'S6': 'COLORADO',
 'S7': 'CONNECTICUT',
 'S8': 'DELAWARE',
 'S9': 'FLORIDA',
 'S10': 'GEORGIA',
 'S11': 'HAWAII',
 'S12': 'IDAHO',
 'S13': 'ILLINOIS',
 'S14': 'INDIANA',
 'S15': 'IOWA',
 'S16': 'KANSAS',
 'S17': 'KENTUCKY',
 'S18': 'LOUISIANA',
 'S19': 'MAINE',
 'S20': 'MARYLAND',
 'S21': 'MASSACHUSETTS',
 'S22': 'MICHIGAN',
 'S23': 'MINNESOTA',
 'S24': 'MISSISSIPPI',
 'S25': 'MISSOURI',
 'S26': 'MONTANA',
 'S27': 'NEBRASKA',
 'S28': 'NEVADA',
 'S29': 'NEW HAMPSHIRE',
 'S30': 'NEW JERSEY',
 'S31': 'NEW MEXICO',
 'S32': 'NEW YORK',
 'S33': 'NORTH CAROLIN',
 'S34': 'NORTH DAKOTA',
 'S35': 'OHIO',
 'S36': 'OKLAHOMA',
 'S37': 'OREGON',
 'S38': 'PENNSYLVANIA',
 'S39': 'RHODE ISLAND',
 'S40': 'SOUTH CAROLIN',
 'S41': 'SOUTH DAKOTA',
 'S42': 'TENNESSEE',
 'S43': 'TEXAS',
 'S44': 'UTAH',
 'S45': 'VERMONT',
 'S46': 'VIRGINIA',
 'S47': 'WASHINGTON',
 'S48': 'WEST VIRGINIA',
 'S49': 'WISCONSIN',
 'S50': 'WYOMING'}


mdim = min(13, max([len(i) for i in ss.values()]))
ss = {k.rjust(mdim):v.rjust(mdim) for k, v in ss.items()}
yy = {k.rjust(mdim):str(v).rjust(mdim) for k, v in yy.items()}

f = open('sub/sub.txt', 'rt').read()
for k, v in {**yy, **ss}.items():
    f = f.replace(k, v)
g = open('sub/subbed.txt', 'wt')
g.write(f)
g.close()

