import collections

def parse_log_line(line):
    parts = line.strip().split()
    if len(parts) < 5:
        return None

    status = parts[2]
    ip_part = parts[-1]
    if not ip_part.startswith("ip="):
        return None

    ip = ip_part.split("=")[1]
    return status, ip

def analyze_log(path, fail_threshold=5):
    failed_by_ip = collections.Counter()

    with open(path, "r") as f:
        for line in f:
            parsed = parse_log_line(line)
            if not parsed:
                continue
            status, ip = parsed
            if status.upper() == "FAILED":
                failed_by_ip[ip] += 1

    print("Failed login attempts by IP:")
    for ip, count in failed_by_ip.most_common():
        print(f"{ip}: {count} failures")

    print("\nSuspicious IPs (>= threshold):")
    for ip, count in failed_by_ip.items():
        if count >= fail_threshold:
            print(f"{ip} is suspicious with {count} failed attempts")

if __name__ == "__main__":
    analyze_log("sample_log.txt", fail_threshold=3)
