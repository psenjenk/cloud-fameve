# Cloud Fameve - WordPress Docker Deployment

A secure and scalable WordPress deployment using Docker containers.

## Features

- WordPress with Apache
- MySQL 5.7 database
- Environment variable configuration
- Health checks
- SSL support
- Security headers
- Persistent volumes
- Monitoring capabilities
  - Prometheus metrics collection
  - Grafana dashboards
  - Alert management
  - Performance monitoring
  - Resource usage tracking

## Prerequisites

- Docker
- Docker Compose
- Git

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/cloud-fameve.git
cd cloud-fameve
```

2. Create and configure environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

3. Start the containers:
```bash
docker-compose up -d
```

4. Access WordPress:
- Open http://localhost:8000 in your browser
- Complete the WordPress installation

## Configuration

### Environment Variables

Edit the `.env` file to configure:
- Database credentials
- WordPress settings
- Port mappings
- Monitoring settings
  - Grafana admin password
  - Prometheus retention period
  - Alert manager email

### SSL Configuration

1. Place your SSL certificates in the `ssl` directory
2. Uncomment SSL configuration in `apache2.conf`
3. Update port mappings in `docker-compose.yml`

## Monitoring

### Grafana Dashboard
- Access Grafana at http://localhost:3000
- Default credentials: admin / (password from .env)
- Pre-configured dashboards for:
  - CPU and Memory usage
  - MySQL performance
  - Nginx metrics
  - WordPress health

### Prometheus Metrics
- Access Prometheus at http://localhost:9090
- Collects metrics from:
  - WordPress container
  - MySQL database
  - Nginx server
  - System resources

### Alerts
Configured alerts for:
- High CPU usage (>80%)
- High memory usage (>512MB)
- MySQL connection issues
- Nginx error rates
- Slow query detection

### Container Health Checks
- WordPress container health monitoring
- MySQL database health checks
- Nginx server status
- Automatic container recovery

## Security Features

- Secure headers
- SSL support
- Environment variable configuration
- Proper file permissions
- Regular security updates
- Monitoring and alerting for security events

## Maintenance

### Backup

```bash
# Backup database
docker-compose exec db mysqldump -u root -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} > backup.sql

# Backup WordPress files
tar -czf wordpress_backup.tar.gz ./app
```

### Update

```bash
# Update containers
docker-compose pull
docker-compose up -d
```

## Troubleshooting

1. Check container status:
```bash
docker-compose ps
```

2. View logs:
```bash
docker-compose logs -f
```

3. Restart services:
```bash
docker-compose restart
```

4. Check monitoring:
- View Grafana dashboards for performance issues
- Check Prometheus metrics for anomalies
- Review alert history in Grafana

## License

This project is licensed under the GNU General Public License v3.0 with special authorization from the original owner. See the [LICENSE](LICENSE) file for details.

Key points about the license:
- Free to use, modify, and distribute
- Must include original copyright notice
- Must distribute under the same license terms
- Original owner maintains rights to official repository and updates
- Commercial use is permitted
- Attribution requirements apply

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

Please ensure your contributions comply with the license terms and include appropriate attribution.
